Alwinner A23 LineageOS 14.1 device tree for Oysters T72MS/T72MD

AL-A23-751_v2.1 board
----------------------------------------------------
Hardware	: sun8i

To initialize your local repository using the LineageOS trees, use a command like this:

    $ repo init -u https://github.com/LineageOS/android.git -b cm-14.1

Then to sync up:

    $ repo sync

Build:

	$ . build/envsetup.sh

	$ breakfast t72ms

	$ brunch t72ms



