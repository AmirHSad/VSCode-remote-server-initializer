commit_id=$(ls --sort=time ~/.config/Code/User/globalStorage/ms-vscode-remote.remote-ssh/ | head -n 1 | awk -F'-' '{print $5}')

sshpass -p "${2}" ssh-copy-id -p${4:-22} ${3:-$(whoami)}@$1
ssh -p ${4:-22} ${3:-$(whoami)}@$1 << EOF
    cd \$(mktemp -d)

    # Download url is: https://update.code.visualstudio.com/commit:${commit_id}/server-linux-x64/stable
    wget "https://update.code.visualstudio.com/commit:${commit_id}/server-linux-x64/stable" -O vscode-server-linux-x64-${commit_id}.tar.gz

    mkdir -p ~/.vscode-server/bin/${commit_id}
    rm -rf ~/.vscode-server/bin/${commit_id}/*

    tar zxvf vscode-server-linux-x64-${commit_id}.tar.gz -C ~/.vscode-server/bin/${commit_id} --strip 1
    touch ~/.vscode-server/bin/${commit_id}/0
EOF

