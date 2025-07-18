{
  lib,
  buildPythonPackage,
  ecdsa,
  fetchFromGitHub,
  flask,
  pytestCheckHook,
  python-http-client,
  pythonOlder,
  pyyaml,
  setuptools,
  starkbank-ecdsa,
  werkzeug,
}:

buildPythonPackage rec {
  pname = "sendgrid";
  version = "6.12.4";
  pyproject = true;

  disabled = pythonOlder "3.6";

  src = fetchFromGitHub {
    owner = pname;
    repo = "sendgrid-python";
    tag = version;
    hash = "sha256-TXFoNipUVaSvNquMy9xHHu0h5qxxvWTRw4JUK4acl3E=";
  };

  build-system = [ setuptools ];

  dependencies = [
    ecdsa
    python-http-client
    starkbank-ecdsa
  ];

  nativeCheckInputs = [
    flask
    pytestCheckHook
    pyyaml
    werkzeug
  ];

  disabledTestPaths = [
    # Exclude tests that require network access
    "test/integ/test_sendgrid.py"
    "live_test.py"
  ];

  pythonImportsCheck = [ "sendgrid" ];

  meta = with lib; {
    description = "Python client for SendGrid";
    homepage = "https://github.com/sendgrid/sendgrid-python";
    changelog = "https://github.com/sendgrid/sendgrid-python/blob/${src.tag}/CHANGELOG.md";
    license = with licenses; [ mit ];
    maintainers = with maintainers; [ fab ];
  };
}
