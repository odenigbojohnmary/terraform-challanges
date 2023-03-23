write_files:
- path: /etc/app/key
permissions: '06000'
content: |
    ${private_key}
- path:  /etc/app/key.pub
permissions: '0644'
content: |
    ${public_key}