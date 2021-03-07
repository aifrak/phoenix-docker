import os
import platform
import pytest
import testinfra

# versions used in Dockerfile
NODE_VERSION = '14.16.0'
NPX_VERSION = '6.14.11'
ELIXIR_VERSION = '1.11.3'
ERLANG_VERSION = '23.2.7'

HOME_PATH = os.environ['HOME']
ROOT = 'root'
USER_NAME = 'app-user'
USER_GROUP = 'www-data'
FONTS_PATH = '/usr/local/share/fonts'
OH_MY_ZSH_PATH = HOME_PATH + '/.oh-my-zsh'


@pytest.mark.parametrize('name,version', [
    ('erlang-dev', ''),
    ('erlang-dialyzer', ''),
    ('erlang-parsetools', ''),
    ('inotify-tools', ''),
])
def test_apt_packages(host, name, version):
    package = host.package(name)

    assert package.is_installed
    if version:
        assert package.version


@pytest.mark.parametrize('name,version', [
    ('node', NODE_VERSION),
    ('elixir', ELIXIR_VERSION),
    ('npx', NPX_VERSION),
])
def test_custom_packages(host, name, version):
    version_cmd = host.run(name + ' --version')

    assert version_cmd.succeeded
    if version:
        assert version in version_cmd.stdout


def test_erlang_package(host):
    version_cmd = host.run(
        "erl -eval '{ok, Version} = file:read_file(filename:join([code:root_dir(), \"releases\", erlang:system_info(otp_release), \"OTP_VERSION\"])), io:fwrite(Version), halt().' -noshell")

    assert version_cmd.succeeded
    assert version_cmd.stdout.startswith(ERLANG_VERSION)


def test_current_user(host):
    user = host.user()

    assert user.name == USER_NAME
    assert user.group == USER_GROUP


def test_home_directory(host):
    assert HOME_PATH == '/home/' + USER_NAME


def test_phoenix(host):
    new_project_cmd = host.run('mix phx.new hello')

    assert new_project_cmd.succeeded
