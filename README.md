# simple-docker-symfony
Simple dockerfile for Symfony/Composer LAMP stack. Intended for development. With this setup you are meant to run your MySQL database locally outside of docker.

# Tips
- To access a MySQL database hosted locally on your computer, in your MySQL parameters replace all instances of `localhost` or `127.0.0.1` to `host.docker.internal`
- Ensure that the `WORKDIR` in the dockerfile is configured properly, and that you are `COPY`ing the correct folder.

# Why?
Every docker implementation of Symfony I had seen was either bloated/far too overkill for a simple development project. If you're used to an easier and more widely used stack like MEAN/MERN, you know that you can find hundreds of accessible docker containers, in the case of Symfony, not so much. This creates a barrier to entry for those who wish to use docker with Symfony for the first time, as setting up and dealing with WAMP/LAMP can be a major pain in the ass. 
