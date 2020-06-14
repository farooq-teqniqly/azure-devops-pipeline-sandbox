$pythonVersions = @("3.8.3", "3.7.7", "3.6.10", "3.5.9")

foreach($version in $pythonVersions) {
  docker build -f ubuntu.dockerfile --build-arg=PYTHON_VERSION=$version  -t teqniqly/azure-pipeline-job-python:$version-ubuntu .
  docker push teqniqly/azure-pipeline-job-python:$version-ubuntu
}