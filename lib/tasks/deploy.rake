namespace :deploy do
  desc "Creates and pull the image to DockerHub"
  task start: :environment do
    TAG = `git rev-parse --short HEAD`.strip

    puts "Building Docker image"

    sh "docker build -t andreleoni/inbox-microservice:#{TAG} ."

    IMAGE_ID = `docker images | grep andreleoni\/inbox-microservice | head -n1 | awk '{print $3}'`.strip

    puts "Tagging latest image"
    sh "docker tag #{IMAGE_ID} andreleoni/inbox-microservice:latest"

    puts "Pushing Docker image"
    sh "docker push andreleoni/inbox-microservice:#{TAG}"
    sh "docker push andreleoni/inbox-microservice:latest"

    sh "cat kube/deployment.yaml | sed 's/\$\$DOCKER_IMAGE/andreleoni\\/inbox-microservice:#{TAG}/g' | kubectl apply -f -"

    puts "Done"
  end
end
