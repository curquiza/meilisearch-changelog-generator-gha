FROM openjdk:12-alpine
LABEL 'curquiza <clementine@meilisearch.com>'
LABEL 'com.github.actions.name'='meilisearch-changelog-generator-gha'
LABEL 'com.github.actions.description'='Create a release changelog based on the Milestones'
LABEL 'com.github.actions.icon'='file'
LABEL 'com.github.actions.color'='purple'

ENV RELEASE_NOTE_GENERATOR_VERSION='v0.0.7'

COPY *.sh /
RUN chmod +x JSON.sh && \
    wget -O github-release-notes-generator.jar https://github.com/spring-io/github-changelog-generator/releases/download/${RELEASE_NOTE_GENERATOR_VERSION}/github-changelog-generator.jar

COPY entrypoint.sh /

ENTRYPOINT ['sh', '/entrypoint.sh']
