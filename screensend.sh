#!/bin/bash

source "${HOME}/.screensend"

local_dir=${SS_LOCAL_DIR:="${HOME}/Screenshots"}
remote_host=${SS_REMOTE_HOST}
remote_dir=${SS_REMOTE_DIR}
remote_pattern=${SS_REMOTE_URL}

screen_file=$(ls -Frt ${local_dir} | grep "[^/]$" | tail -n 1)
screen_path="${local_dir}/$screen_file"
if [ -e "$screen_path" ]; then
  # rename file as sha1 hash
  base_name=${screen_file%.*}
  hash_name="$(printf '%s' "$base_name" | openssl sha1).png"
  hash_path="$local_dir/$hash_name"
  mv "$screen_path" "$hash_path"

  # copy file to remote tmp directory
  remote_tmp_path="~/tmp/$hash_name"
  echo "Copying to remote $remote_tmp_path..."
  $(scp "$hash_path" "$remote_host:$remote_tmp_path")

  # move file from remote tmp to remote public directory
  echo "Moving to $remote_dir..."
  $(ssh -t "$remote_host" "sudo mv $remote_tmp_path $remote_dir")

  # echo filename for copying
  echo "File available at:"
  echo "${remote_pattern/:file/$hash_name}"
else
  echo "No screenshots found"
fi