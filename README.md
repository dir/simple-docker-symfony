# simple-docker-symfony
Simple dockerfile for Symfony/Composer LAMP stack. Intended for development. With this setup you are meant to run your MySQL database locally outside of docker.

# Tips
- To access a MySQL database hosted locally on your computer, in your MySQL parameters replace all instances of localhost or 127.0.0.1 to host.docker.internal
- Ensure that the WORKDIR in the dockerfile is configured properly, and that you are COPYing the correct folder.
