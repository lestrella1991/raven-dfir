#!/usr/bin/env bash

DB="<FULL/PATH/TO/KDBX/FILE"

read -s -p "Master password: " master >&2
echo >&2

if [[ -z "$master" ]]; then
    echo "echo 'Master password vacía' >&2; return 1" 
    exit 1
fi

get_kp() {
    local attr="$1"
    local entry="$2"

    printf '%s\n' "$master" | keepassxc-cli show -q -a "$attr" "$DB" "$entry"
}

TF_VAR_token="$(get_kp password "<PATH/TO/PROXMOX/TOKEN>")" || exit 1
TF_VAR_secret="$(get_kp password "<PATH/TO/PROXMOX/SECRET>")" || exit 1
TF_VAR_user="$(get_kp username "<PATH/TO/VM/User/value>")" || exit 1
TF_VAR_password="$(get_kp password "<PATH/TO/VM/User/Password/value>")" || exit 1
TF_VAR_ssh="$(cat "<PATH/OF/PUBLIC/SSH/KEY>")" || exit 1

printf 'export TF_VAR_token=%q\n' "$TF_VAR_token"
printf 'export TF_VAR_secret=%q\n' "$TF_VAR_secret"
printf 'export TF_VAR_user=%q\n' "$TF_VAR_user"
printf 'export TF_VAR_password=%q\n' "$TF_VAR_password"
printf 'export TF_VAR_ssh=%q\n' "$TF_VAR_ssh"

