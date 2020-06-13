class App {
  [string] $DockerRepo

  App([string] $dockerRepo) {
    $this.DockerRepo = $dockerRepo
  }

  [string[]] Build([string[]] $pythonVersions, [string] $linuxFlavor) {
    $imagePaths = @()

    foreach ($version in $pythonVersions) {
      $tag = "$version-$linuxFlavor"
      $imagePath = $this.DockerRepo + ":" + $tag
      docker build --build-arg PYTHON_VERSION=$version -t $imagePath .
      $imagePaths += $imagePath
    }
    
    return $imagePaths
  }

  Push([string[]] $imagePaths) {
    foreach ($imagePath in $imagePaths) {
      docker push $imagePath
    }
  }
}
$pythonVersions = @("3.8.3", "3.7.7", "3.6.10", "3.5.9")
$dockerUsername = "teqniqly"
$dockerRepo =  $dockerUserName + "/azure-pipeline-job-python"
$dockerToken = "90d7c5ba-f44e-4ef5-963e-a1c26d0545ac"
$linuxFlavor = "alpine"

try {
  docker login -u $dockerUsername -p $dockerToken
  $app = New-Object -TypeName App -ArgumentList @($dockerRepo)
  $imagePaths = $app.Build($pythonVersions, $linuxFlavor)
  Write-Host $imagePaths
  $app.Push($imagePaths)
}
catch {
  Write-Error $_
}

