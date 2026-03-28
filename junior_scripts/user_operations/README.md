# userctr.sh — User Management Script

Bash script for automating teacher and student account creation on classroom servers.

## Usage
```bash
sh userctr.sh <operation> <teacher_name> <student_prefix> <student_count>
```

## Operations

**add** — creates teacher and student accounts with random passwords:
```bash
sh userctr.sh add teacher stu 6
# teacher:901231
# stu1:271828
# stu2:928172
# stu3:****** ← user already existed
```

**del** — deletes teacher and student accounts including home directories:
```bash
sh userctr.sh del teacher stu 6
```

## Parameters

| Parameter | Description | Validation |
|-----------|-------------|------------|
| operation | `add` or `del` | required |
| teacher_name | teacher username | required |
| student_prefix | prefix for student names | lowercase letters only |
| student_count | number of students | integer 1-10 |

## Features

- Input validation with clear error messages
- Random 6-digit password generation per user
- Skips existing users on `add` (prints `username:******`)
- Silent delete — skips non-existing users without error
- Users created with `/bin/zsh` shell
- Teacher added to `sudo` group

## Requirements

- Linux system with `useradd`, `userdel`, `shuf`
- sudo privileges