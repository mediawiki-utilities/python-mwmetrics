import os

from setuptools import find_packages, setup


def read(fname):
    return open(os.path.join(os.path.dirname(__file__), fname)).read()

def requirements(fname):
    return [line.strip()
            for line in open(os.path.join(os.path.dirname(__file__), fname))]

setup(
    name = "mwmetrics",
    version = "0.0.1",
    author = "Aaron Halfaker",
    author_email = "ahalfaker@wikimedia.org",
    description = "A collection of scripts and utilities for extracting " +
                  "behavioral metrics from Wikipedia editors",
    license = "MIT",
    url = "https://github.com/halfak/mwmetrics",
    packages=find_packages(),
    entry_points = {
        'console_scripts': [
            'mwmetrics=mwmetrics.mwmetrics:main',
        ],
    },
    long_description = read('README.md'),
    install_requires = ['docopt', 'mediawiki-utilities'],
    classifiers=[
        "Programming Language :: Python :: 3",
        "Development Status :: 3 - Alpha",
        "License :: OSI Approved :: MIT License",
        "Intended Audience :: Science/Research",
        "Intended Audience :: System Administrators",
        "Intended Audience :: Developers",
        "Operating System :: OS Independent",
        "Topic :: Utilities",
        "Topic :: Scientific/Engineering"
    ]
)
