$pythonVersions = @("3.8.3", "3.7.7", "3.6.10", "3.5.9")
$repo = "teqniqly/azure-pipeline-job-python"

foreach($version in $pythonVersions) {
  docker build -f ubuntu.dockerfile --build-arg=PYTHON_VERSION=$version --build-arg=PYTHON_SHORT_VERSION=$version.SubString(0, 3)  -t $repo + ":" + $version-ubuntu .
  docker push $repo + ":" + $version-ubuntu
}