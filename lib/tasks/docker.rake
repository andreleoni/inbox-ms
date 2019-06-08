namespace :docker do
  desc "Creates and pull the image to DockerHub"
  task push_image: :environment do
    TAG = `git rev-parse --short HEAD`.strip

    puts "Building Docker image"
    sh "docker build -t andreleoni/inbox-microservice:#{TAG} ."

    IMAGE_ID = `docker images | grep andreleoni\/inbox-microservice | head -n1 | awk '{print $3}'`.strip

    puts "Tagging latest image"
    sh "docker tag #{IMAGE_ID} andreleoni/inbox-microservice:latest"

    puts "Pushing Docker image"
    sh "docker push andreleoni/inbox-microservice:#{TAG}"
    sh "docker push andreleoni/inbox-microservice:latest"

    puts "Done"
  end

  desc "Creates and pull the image to DockerHub for circleci"
  task push_image_circle_ci: :environment do
    TAG = `git rev-parse --short HEAD`.strip

    puts "Building Docker image"
    sh "docker build -t andreleoni/inbox-ms-circleci:#{TAG} -f docker/CircleCI_Dockerfile ."

    IMAGE_ID = `docker images | grep andreleoni\/inbox-ms-circleci | head -n1 | awk '{print $3}'`.strip

    puts "Tagging latest image"
    sh "docker tag #{IMAGE_ID} andreleoni/inbox-ms-circleci:latest"

    puts "Pushing Docker image"
    sh "docker push andreleoni/inbox-ms-circleci:#{TAG}"
    sh "docker push andreleoni/inbox-ms-circleci:latest"

    puts "Done"
  end
end
