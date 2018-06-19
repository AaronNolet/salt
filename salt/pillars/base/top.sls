include:
  - users
  - users.sudo
  - users.bashrc
  - users.profile
  - users.vimrc
  - users.user_files

base:
  'nginx*':
    - users

users:
  testuser:
    fullname: Test User
    password: eZ#xYJj4
    sudouser: True
