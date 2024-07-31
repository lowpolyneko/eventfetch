#!/bin/sh
# Written by Neko (lowpolyneko@protonmail.ch)

# install neo(wo)fetch
if [ ! -f neowofetch ]
then
    curl -Ls nf.hydev.org -o neowofetch
    chmod +x neowofetch
fi


# gather event info interactively
if [ -z "${EVENT_IMG}" ]
then
    echo "Event Flyer Image (leave blank for default-logo.png): "
    read -r EVENT_IMG && [ -z "${EVENT_IMG}" ] && EVENT_IMG="default-logo.png"
fi

if [ -z "${EVENT_TITLE}" ]
then
    echo "Event Title: "
    read -r EVENT_TITLE
fi

if [ -z "${EVENT_DATE}" ]
then
    echo "Event Date: "
    read -r EVENT_DATE
fi

if [ -z "${EVENT_TIME}" ]
then
    echo "Event Time: "
    read -r EVENT_TIME
fi

if [ -z "${EVENT_ROOM}" ]
then
    echo "Event Location (leave blank for SELE 2264): "
    read -r EVENT_ROOM && [ -z "${EVENT_ROOM}" ] && EVENT_ROOM="SELE 2264"
fi

if [ -z "${EVENT_CONTACT}" ]
then
    echo "Event Contact (leave blank for lug-officers@uic.edu): "
    read -r EVENT_CONTACT && [ -z "${EVENT_CONTACT}" ] && EVENT_CONTACT="lug-officers@uic.edu"
fi

if [ -z "${EVENT_DISCORD}" ]
then
    echo "Event Discord (leave blank for LUG Discord join code): "
    read -r EVENT_DISCORD && [ -z "${EVENT_DISCORD}" ] && EVENT_DISCORD="discord.gg/kj4pFaGf"
fi

if [ -z "${EVENT_WEBSITE}" ]
then
    echo "Event Website (leave blank for lug.cs.uic.edu): "
    read -r EVENT_WEBSITE && [ -z "${EVENT_WEBSITE}" ] && EVENT_WEBSITE="lug.cs.uic.edu"
fi


# generate neo(wo)fetch config file
cat >neowofetch.conf <<EOF
print_info() {
    prin "${EVENT_TITLE}"
    info underline

    prin "Date" "${EVENT_DATE}"
    prin "Time" "${EVENT_TIME}"
    prin "Room" "${EVENT_ROOM}"

    prin
EOF


# read event description while generating config
if [ -z "${EVENT_DESC}" ]
then
    echo "Event Description (press Ctrl-D/EOF to finish): "
    while IFS= read -r EVENT_DESC_LINE
    do
        echo "    prin \"Info\" \"${EVENT_DESC_LINE}\"" >> neowofetch.conf
    done
else
    printf "%b" "${EVENT_DESC}" | while IFS= read -r EVENT_DESC_LINE
    do
        echo "    prin \"Info\" \"${EVENT_DESC_LINE}\"" >> neowofetch.conf
    done
fi


cat >>neowofetch.conf <<EOF

    prin

    prin "Contact" "${EVENT_CONTACT}"
    prin "Discord" "${EVENT_DISCORD}"
    prin "Website" "${EVENT_WEBSITE}"

    info cols
}

image_backend="sixel"
image_source="${EVENT_IMG}"
EOF


# display and screenshot
clear
./neowofetch --config neowofetch.conf --sixel default-logo.png


# cleanup
rm -f neowofetch.conf

# vim: sw=4:ts=4:expandtab
