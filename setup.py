"""
To push a new version to PyPi, update the version number
in rfhub/version.py and then run the following commands:

    $ python setup.py sdist
    $ python3 -m twine upload dist/*

"""
from setuptools import setup

__version__: str = "0.0.0"
filename: str = 'rfhub/version.py'
exec(open(filename).read())

setup_requires_packages: list = ['wheel']
install_requires_packages: list = [
    'Flask>=3.0.3',
    'Jinja2>=3.1.4',
    'MarkupSafe>=2.1.5',
    'PyYAML>=6.0.2',
    'Werkzeug>=3.0.4',
    'argh>=0.31.3',
    'itsdangerous>=2.2.0',
    'tornado>=6.4.1',
    'pathtools3>=0.2.1',
    'requests>=2.32.3',
    'robotframework>=7.0.1',
    'robotframework-requests>=0.9.7',
    'robotframework-seleniumlibrary>=6.6.1',
    'watchdog>=4.0.2'
]
test_requires_packages: list = ['coverage']

setup(
    name='robotframework-hub-bli',
    version=__version__,
    author='Bryan Oakley',
    author_email='bryan.oakley@gmail.com',
    maintainer='Bert Lindemann',
    maintainer_email='bert.lindemann@gmail.com',
    url='https://github.com/bli74/robotframework-hub/',
    keywords='robotframework',
    license='Apache License 2.0',
    description='Webserver for robot framework assets',
    long_description=open('README.md').read(),
    long_description_content_type="text/markdown",
    zip_safe=True,
    include_package_data=True,
    python_requires=">=3.8",
    setup_requires=setup_requires_packages,
    install_requires=install_requires_packages,
    extras_require={
        'test': test_requires_packages
    },
    classifiers=[
        "Development Status :: 5 - Production/Stable",
        "License :: OSI Approved :: Apache Software License",
        "Operating System :: OS Independent",
        "Framework :: Robot Framework",
        "Programming Language :: Python :: 3",
        "Topic :: Software Development :: Testing",
        "Topic :: Software Development :: Quality Assurance",
        "Intended Audience :: Developers",
    ],
    packages=[
        'rfhub',
        'rfhub.blueprints',
        'rfhub.blueprints.api',
        'rfhub.blueprints.doc',
        'rfhub.blueprints.dashboard',
    ],
    scripts=[],
    entry_points={
        'console_scripts': [
            "rfhub = rfhub.__main__:main"
        ]
    }
)
