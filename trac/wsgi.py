import sys
import os

sys.stdout = sys.stderr

# This variable is only for execution context.
# It has no relation to TRAV_ENV of container build
os.environ['TRAC_ENV'] = '/var/trac'

os.environ['PYTHON_EGG_CACHE'] = '/etc/trac/.eggs/'

from trac.web.standalone import AuthenticationMiddleware
from trac.web.main import dispatch_request
from trac.web.auth import BasicAuthentication

def application(environ, start_application):
    auth = {"*" : BasicAuthentication("/var/trac/users", "realm")}
    wsgi_app = AuthenticationMiddleware(dispatch_request, auth)
    return wsgi_app(environ, start_application)
