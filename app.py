import os
import subprocess

etl_directory = './.'
excluded_files = {'app.py', 'ETL_ETLs_name.py', 'functions.py'}

try:
    
    # Excecuting all ETL scripts located in the current directory
    etl_scripts = [f for f in os.listdir(etl_directory) if f.endswith('.py') and f not in excluded_files]

    # Excecuting particular ETL pipelines in a defined order
    # etl_scripts = [] --> [etl_script_#1, etl_script_#2, etl_script_#3, ...]

    for script in etl_scripts:
        print(f'Running {script} - ')
        script_path = os.path.join(etl_directory, script)
        subprocess.run(['py', script_path])

except OSError as e:
    print(f"Error accessing directory {etl_directory}: {e}")
    exit(1)