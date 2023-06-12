#!/usr/bin/env bash
#
# configure.sh
# Sets up home directory

COMMON_ROOT_DOT=~/".dot/config"
COMMON_ROOT_CONFIG=~/".config"

# Make sure .config exists
if [ ! -d "${COMMON_ROOT_CONFIG}" ]
then
	mkdir "${COMMON_ROOT_CONFIG}"
fi

# Set up symlink mirror into .config
if [[ "$OSTYPE" == 'linux-gnu'* ]]
then
	cp --recursive \
		--symbolic-link \
		--backup \
		--suffix '.old' \
		-- \
		"${COMMON_ROOT_DOT}/." \
		"${COMMON_ROOT_CONFIG}/"
elif [[ "$OSTYPE" == 'darwin'* ]]
then
	cp -R -s -n "${COMMON_ROOT_DOT}/" \
		"${COMMON_ROOT_CONFIG}/"
fi

# Setup additional symlinks

function deleteIfSymlink()
{
	if [ -L "$1" ]
	then
		rm "$1"
	elif [ -f "$1" ]
	then
		mv "$1" "${1}.old"
	fi
}

# bash
CURRENT_FILE=~/".profile"
deleteIfSymlink "${CURRENT_FILE}"
ln -s "${COMMON_ROOT_CONFIG}/bash/profile" \
	"${CURRENT_FILE}"

CURRENT_FILE=~/".bashrc"
deleteIfSymlink "${CURRENT_FILE}"
ln -s "${COMMON_ROOT_CONFIG}/bash/bashrc" \
	"${CURRENT_FILE}"

# tmux
CURRENT_FILE=~/".tmux.conf"
deleteIfSymlink "${CURRENT_FILE}"
ln -s "${COMMON_ROOT_CONFIG}/tmux/tmux.conf" \
	"${CURRENT_FILE}"

# git
CURRENT_FILE=~/".gitconfig"
deleteIfSymlink "${CURRENT_FILE}"
ln -s "${COMMON_ROOT_CONFIG}/git/gitconfig" \
	"${CURRENT_FILE}"
