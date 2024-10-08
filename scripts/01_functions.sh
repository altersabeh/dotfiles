#!/usr/bin/env bash

# Function to get conda envs
get_conda_envs() {
  conda env list | awk '$1 != "#" && $1 != "base" {print $1}'
}

# Function to append a path to CLASSPATH if it's not already included
append_to_classpath() {
  local path_to_add="$1"
  if [[ ":$CLASSPATH:" != *":$path_to_add:"* ]]; then
    CLASSPATH="${CLASSPATH:+${CLASSPATH}:}$path_to_add"
  fi
}

# Function to prepend a path to CLASSPATH if it's not already included
prepend_to_classpath() {
  local path_to_add="$1"
  if [[ ":$CLASSPATH:" != *":$path_to_add:"* ]]; then
    CLASSPATH="$path_to_add${CLASSPATH:+:${CLASSPATH}}"
  fi
}

# Function to appemd a path to MANPATH if it's not already included
append_to_manpath() {
  local path_to_add="$1"
  if [[ ":$MANPATH:" != *":$path_to_add:"* ]]; then
    MANPATH="${MANPATH:+${MANPATH}:}$path_to_add"
  fi
}

# Function to prepend a path to MANPATH if it's not already included
prepend_to_manpath() {
  local path_to_add="$1"
  if [[ ":$MANPATH:" != *":$path_to_add:"* ]]; then
    MANPATH="$path_to_add${MANPATH:+:${MANPATH}}"
  fi
}

# Function to append a path to ADA_OBJECTS_PATH if it's not already included
append_to_ada_objects_path() {
  local path_to_add="$1"
  if [ -d "$path_to_add" ]; then
    if [[ ":$ADA_OBJECTS_PATH:" != *":$path_to_add:"* ]]; then
      ADA_OBJECTS_PATH="${ADA_OBJECTS_PATH:+${ADA_OBJECTS_PATH}:}$path_to_add"
    fi
  fi
}

# Function to prepend a path to ADA_OBJECTS_PATH if it's not already included
prepend_to_ada_objects_path() {
  local path_to_add="$1"
  if [ -d "$path_to_add" ]; then
    if [[ ":$ADA_OBJECTS_PATH:" != *":$path_to_add:"* ]]; then
      ADA_OBJECTS_PATH="$path_to_add${ADA_OBJECTS_PATH:+:${ADA_OBJECTS_PATH}}"
    fi
  fi
}

# Function to append a path to ADA_INCLUDE_PATH if it's not already included
append_to_ada_include_path() {
  local path_to_add="$1"
  if [ -d "$path_to_add" ]; then
    if [[ ":$ADA_INCLUDE_PATH:" != *":$path_to_add:"* ]]; then
      ADA_INCLUDE_PATH="${ADA_INCLUDE_PATH:+${ADA_INCLUDE_PATH}:}$path_to_add"
    fi
  fi
}

# Function to prepend a path to ADA_INCLUDE_PATH if it's not already included
prepend_to_ada_include_path() {
  local path_to_add="$1"
  if [ -d "$path_to_add" ]; then
    if [[ ":$ADA_INCLUDE_PATH:" != *":$path_to_add:"* ]]; then
      ADA_INCLUDE_PATH="$path_to_add${ADA_INCLUDE_PATH:+:${ADA_INCLUDE_PATH}}"
    fi
  fi
}

# Function to append a path to PATH if it's not already included
append_to_path() {
  local path_to_add="$1"
  if [ -d "$path_to_add" ]; then
    if [[ ":$PATH:" != *":$path_to_add:"* ]]; then
      PATH="${PATH:+${PATH}:}$path_to_add"
    fi
  fi
}

# Function to prepend a path to PATH if it's not already included
prepend_to_path() {
  local path_to_add="$1"
  if [ -d "$path_to_add" ]; then
    if [[ ":$PATH:" != *":$path_to_add:"* ]]; then
      PATH="$path_to_add${PATH:+:${PATH}}"
    fi
  fi
}

# Function to append a path to LD_LIBRARY_PATH if it's not already included
append_to_ld_library_path() {
  local path_to_add="$1"
  if [ -d "$path_to_add" ]; then
    if [[ ":$LD_LIBRARY_PATH:" != *":$path_to_add:"* ]]; then
      LD_LIBRARY_PATH="${LD_LIBRARY_PATH:+${LD_LIBRARY_PATH}:}$path_to_add"
    fi
  fi
}

# Function to prepend a path to LD_LIBRARY_PATH if it's not already included
prepend_to_ld_library_path() {
  local path_to_add="$1"
  if [ -d "$path_to_add" ]; then
    if [[ ":$LD_LIBRARY_PATH:" != *":$path_to_add:"* ]]; then
      LD_LIBRARY_PATH="$path_to_add${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}"
    fi
  fi
}

# Function to append a path to LIBRARY_PATH if it's not already included
append_to_library_path() {
  local path_to_add="$1"
  if [ -d "$path_to_add" ]; then
    if [[ ":$LIBRARY_PATH:" != *":$path_to_add:"* ]]; then
      LIBRARY_PATH="${LIBRARY_PATH:+${LIBRARY_PATH}:}$path_to_add"
    fi
  fi
}

# Function to prepend a path to LIBRARY_PATH if it's not already included
prepend_to_library_path() {
  local path_to_add="$1"
  if [ -d "$path_to_add" ]; then
    if [[ ":$LIBRARY_PATH:" != *":$path_to_add:"* ]]; then
      LIBRARY_PATH="$path_to_add${LIBRARY_PATH:+:${LIBRARY_PATH}}"
    fi
  fi
}

# Function to append a append to CPATH if it's not already included
append_to_cpath() {
  local path_to_add="$1"
  if [ -d "$path_to_add" ]; then
    if [[ ":$CPATH:" != *":$path_to_add:"* ]]; then
      CPATH="${CPATH:+${CPATH}:}$path_to_add"
    fi
  fi
}

# Function to prepend a path to CPATH if it's not already included
prepend_to_cpath() {
  local path_to_add="$1"
  if [ -d "$path_to_add" ]; then
    if [[ ":$CPATH:" != *":$path_to_add:"* ]]; then
      CPATH="$path_to_add${CPATH:+:${CPATH}}"
    fi
  fi
}

# Function to add an options to _JAVA_OPTIONS if it's not already included
add_to_java_options() {
  local option_to_add="$1"
  if [[ "$_JAVA_OPTIONS" != *"$option_to_add"* ]]; then
    _JAVA_OPTIONS="${_JAVA_OPTIONS:+${_JAVA_OPTIONS} }$option_to_add"
  fi
}

# Function to check if command exist
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Function to check if a file exist and then source it
source_if_exists() {
  local file="$1"
  if [ -f "$file" ]; then
    . "$file" >/dev/null 2>&1
  fi
}

# Function to check if a directory exist and then delete it
del_if_exists() {
  local file="$1"
  if [ -d "$file" ]; then
    rm -rf "$file" >/dev/null 2>&1
  fi
}

eval_if_exists() {
  local command="$1"
  local message="$2"
  if command_exists $command; then
    eval "$($command $message)"
  fi
}

# Function to check if a command exist and then create an alias
alias_if_exists() {
  local command="$1"
  local alias_name="$2"
  if command_exists $command; then
    alias "$alias_name"="$command"
  fi
}

# Function to determine the installed version of GCC
determine_installed_gcc() {
  if command -v "${XDG_DATA_HOME}/gcc/bin/gcc" >/dev/null 2>&1; then
    GCC_PATH="${XDG_DATA_HOME}/gcc"
  else
    GCC_PATH="$(dirname "$(dirname "$(command -v gcc)")")"
  fi

  GCC_MAJOR_VERSION="$("${GCC_PATH}"/bin/gcc --version | awk '/gcc/ { print $3 }' | cut -d. -f1)"
  X86_64_LIB_PATH="${GCC_PATH}/lib/gcc/x86_64-linux-gnu/${GCC_MAJOR_VERSION}"
}
