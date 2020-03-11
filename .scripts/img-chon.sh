#!/bin/bash

IMG_BASE="$HOME"
DATABASE="$HOME/Pictures/image_tags.sqlite"
SQLITE="sqlite3"

SQL="$SQLITE $DATABASE"
SXIV="sxiv -t -"

join_by () {
    local IFS="$1"
    shift
    echo "$*"
}

sp="/-\|"
sc=0
spin() {
   printf "\r%s [%s/%s] %s" "${sp:sc++:1}" "$1" "$2" "$3"
   if ((sc==${#sp})); then
       sc=0
   fi
}
endspin() {
   printf "\r\n"
}

get_hash() {
    [ -f "$1" ] || exit 1
    read -ra sha < <(sha256sum "$1")
    echo "${sha[0]}"
}

case $1 in
    "init")
        $SQL "CREATE TABLE image (
                  path STRING NOT NULL UNIQUE ON CONFLICT REPLACE,
                  hash STRING PRIMARY KEY NOT NULL UNIQUE ON CONFLICT ABORT
              );"
        $SQL "CREATE TABLE image_tag (
                  hash STRING NOT NULL,
                  tag STRING NOT NULL,
                  UNIQUE (hash, tag) ON CONFLICT ABORT
              );"
        $SQL "CREATE TRIGGER image_exists
              BEFORE INSERT ON image_tag
              BEGIN
                  SELECT CASE
                      WHEN (SELECT COUNT(*) FROM image WHERE image.hash = NEW.hash) = 0 THEN
                          RAISE(FAIL, 'image not in database')
                      END;
              END;"
        ;;
    "add")
        total="${#@}"
        i=0
        for f in "${@:2}"; do
            spin "$i" "$total" "$f"
            i=$((i+1))
            hsh="$(get_hash "$f")"
            path="$(realpath --relative-to="$IMG_BASE" "$f")"
            $SQL "INSERT INTO image (path, hash) VALUES ('$path', '$hsh');"
        done
        endspin
        ;;
    "tag")
        tag=$2
        for f in "${@:3}"; do
            hsh="$(get_hash "$f")"
            $SQL "INSERT INTO image_tag (hash, tag) VALUES ('$hsh','$tag');"
        done
        ;;
    "untag")
        tag=$2
        for f in "${@:3}"; do
            hsh="$(get_hash "$f")"
            $SQL "DELETE FROM image_tag WHERE (hash, tag) = ('$hsh','$tag');"
        done
        ;;
    "query")
        tags=()
        anti_tags=()
        for t in "${@:2}"; do
            if [[ "$t" == -* ]]; then
                anti_tags+=( "'${t:1}'" )
            else
                tags+=( "'$t'" )
            fi
        done
        tags_str=$(join_by , "${tags[@]}")
        anti_tags_str=$(join_by , "${anti_tags[@]}")
        $SQL "SELECT path FROM image WHERE ${#tags[@]} = (SELECT COUNT(*) FROM image_tag WHERE image.hash = image_tag.hash AND image_tag.tag IN ($tags_str)) AND (0 = (SELECT COUNT(*) FROM image_tag WHERE image.hash = image_tag.hash AND image_tag.tag IN ($anti_tags_str)));" | awk "{ print \"$IMG_BASE/\" \$0 }"
        ;;
    "tags")
        if [ -f "$2" ]; then
            hsh="$(get_hash "$2")"
            $SQL "SELECT DISTINCT tag FROM image_tag WHERE hash = '$hsh';"
        else
            $SQL "SELECT DISTINCT tag FROM image_tag;"
        fi
        ;;
    "query-dmenu")
        selected_tags=()
        while selection=$($0 tags | dmenu -p "Select tags, <esc> when done.") && [ -n "$selection" ]; do
            selected_tags+=("$selection")
        done
        $0 query "${selected_tags[@]}" | $SXIV
        ;;
    "tag-dmenu")
        while selection=$($0 tags | dmenu -p "Select tags, <esc> when done.") && [ -n "$selection" ]; do
            $0 tag "$selection" "${@:2}"
        done
        ;;
    "stats")
        echo "Number of images: $($SQL "SELECT COUNT(*) FROM image;")"
        echo "Number of distinct tags: $($SQL "SELECT COUNT(DISTINCT tag) FROM image_tag;")"
        ;;
    "")
        name="$(basename "$0")"
        echo -e "Usage:"
        echo -e "  $name init                Create a new database."
        echo -e "  $name add IMAGE...        Add new image(s) to the database."
        echo -e "  $name tag TAG IMAGE...    Tag image(s) with TAG."
        echo -e "  $name untag TAG IMAGE...  Remove tag from image(s)."
        echo -e "  $name query TAG...        List images with specified tags."
        echo -e "  $name tags [IMAGE]        Show all tags, or tags for IMAGE."
        echo -e "  $name query-dmenu         Interactively construct a query using dmenu and opens the result in sxiv."
        echo -e "  $name tag-dmenu IMAGE...  Interactively tag specified image(s) using dmenu."
        echo -e "  $name stats               Show database statistics."
        ;;
esac
