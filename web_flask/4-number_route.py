#!/usr/bin/python3
""" Script that starts a Flask web application """
from flask import Flask

app = Flask(__name__)
app.url_map.strict_slashes = False


@app.route('/')
def hello_hbnb():
    """print Hello HBNB"""
    return 'Hello HBNB!'


@app.route('/hbnb')
def hbnb():
    """print HBNB"""
    return 'HBNB'


@app.route('/c/<text>')
def c_is_fun(text):
    """print C then the value of the text variable"""
    return 'C {}'.format(text.replace('_', ' '))


@app.route('/python')
@app.route('/python/<text>')
def python_is_cool(text='is cool'):
    """ Print Python, then the value of the text variable,
    and the text default value: is cool"""
    return 'Python {}'.format(text.replace('_', ' '))


@app.route('/number/<int:n>')
def number(n):
    """ print the number route """
    return '{:d} is a number'.format(n)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
