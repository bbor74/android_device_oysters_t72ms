#
# Copyright (C) 2011 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
build_root=$(pwd) # vendorsetup.sh is sourced by build/envsetup.sh in root of android build tree. Hope that nobody can correctly source it not from root of android tree.

echo "Applying patches"
patches_path="$build_root/device/oysters/t72ms/patches/"
pushd "$patches_path" > /dev/null
unset repos
for patch in `find -type f -name '*.patch'|cut -d / -f 2-|sort`; do
	# Strip patch title to get git commit title - git ignore [text] prefixes in beginning of patch title during git am
	title=$(sed -rn "s/Subject: (\[[^]]+] *)*//p" "$patch")
	absolute_patch_path="$patches_path/$patch"
	# Supported both path/to/repo_with_underlines/file.patch and path_to_repo+with+underlines/file.patch (both leads to path/to/repo_with_underlines)
	repo_to_patch="$(if dirname $patch|grep -q /; then dirname $patch; else dirname $patch |tr '_' '/'|tr '+' '_'; fi)"

	echo -n "Is $repo_to_patch patched for '$title' ?.. "

        if [ ! -d $build_root/$repo_to_patch ] ; then
                echo "$repo_to_patch NOT EXIST! Go away and check your manifests. Skipping this patch."
                continue
        fi

	pushd "$build_root/$repo_to_patch" > /dev/null
	if (git log |fgrep -qm1 "$title" ); then
		echo -n Yes
	  commit_hash=$(git log --oneline |fgrep -m1 "$title"|cut -d ' ' -f 1)
	  if [ q"$commit_hash" != "q" ]; then
		  commit_id=$(git format-patch -1 --stdout $commit_hash |git patch-id|cut -d ' ' -f 1)
		  patch_id=$(git patch-id < $absolute_patch_path|cut -d ' ' -f 1)
		  if [ "$commit_id" = "$patch_id" ]; then
			  echo ', patch matches'
		  else
			  echo ', PATCH MISMATCH!'
			  sed '0,/^$/d' $absolute_patch_path|head -n -3  > /tmp/patch
			  git show --stat $commit_hash -p --pretty=format:%b > /tmp/commit
			  diff -u /tmp/patch /tmp/commit
			  rm /tmp/patch /tmp/commit
			  echo ' Resetting branch!'
			  git checkout $commit_hash~1
			  git am $absolute_patch_path || git am --abort
		  fi
	else
		echo "Unable to get commit hash for '$title'! Something went wrong!"
		sleep 20
	fi
	else
		echo No
		echo "Trying to apply patch $(basename "$patch") to '$repo_to_patch'"
		if ! git am $absolute_patch_path; then
			echo "Failed, aborting git am"
			git am --abort
			sleep 60
		fi
	fi
	popd > /dev/null
done
popd > /dev/null
echo "Applying patches: done"

echo "Updating overlay"
sh device/oysters/t72ms/update-overlay.sh

add_lunch_combo lineage_t72ms-eng
add_lunch_combo lineage_t72ms-user
add_lunch_combo lineage_t72ms-userdebug
