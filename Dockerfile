# Defines the first stage of the multi-stage build
# This stage is used to install dependencies
FROM node:alpine3.16 as install

# NODE_ENV is set to production to ensure that dev dependencies are not installed
ENV NODE_ENV=production

WORKDIR /opt/app

# Copy package and package-lock for installation
# Copy version.js also since it will not change often
COPY package*.json version.js ./

# Install only production dependencies
RUN npm install --production

# This stage is the final stage of the multi-stage build
FROM node:alpine3.16

# Set application specific environment variables
ENV NODE_ENV=production
ENV PORT=3000

# Dynamically set the pre-release tag
# Defaults to empty string to denote a stable release
ARG PRE_RELEASE=""
ENV PRE_RELEASE=${PRE_RELEASE}

# Set the user to a non-root user
# Node is a user that is created by the node base image
USER node:node

# Copies the node_modules, package.json, and version.js from the install stage
COPY --from=install --chown=node:node /opt/app/node_modules ./node_modules
COPY --from=install --chown=node:node /opt/app/package.json /opt/app/version.js ./

# Copies the source code
COPY src ./src

# Expose the port that the application is expected to listen on
EXPOSE ${PORT}

# Run the application
# This command can be overridden
CMD ["node", "src/index.js"]