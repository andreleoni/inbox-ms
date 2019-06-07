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
end
