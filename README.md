# Todo List


## Steps

Create [virtual env](https://docs.python.org/3/tutorial/venv.html) in the project directory
1. python3 -m venv tutorial-env
2. source tutorial-env/bin/activate

Install this package:
pip install psycopg2-binary


Setup CockRoachDB using docker
1. Install Docker
2. execute `./setup-database.sh install`

Run Flask server

export FLASK_APP=todo.py

flask run
