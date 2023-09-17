import subprocess
from datetime import datetime

current_time = datetime.now().strftime('%Y-%m-%d %H:%M:%S')

commit_message = f"Files added to repo at {current_time}"

commands = [
    'git add .',
    'git status',
    f'git commit -m "{commit_message}"',
    'git push'
]

for command in commands:
    try:
        subprocess.run(command, shell=True, check=True)
    except subprocess.CalledProcessError as e:
        print(f"Error running command: {e.cmd}")
        
print()
print(f">> Changes have been added, committed, and pushed successfully..!!")
