FROM rust:1.63

LABEL "maintainer"="curquiza <clementine@meilisearch.com>"
LABEL "com.github.actions.name"="meilisearch-changelog-generator-gha"
LABEL "com.github.actions.description"="Create a release changelog based on the Milestones"
LABEL "com.github.actions.icon"="file"
LABEL "com.github.actions.color"="purple"

# Install GitHub CLI (gh)
RUN apt update && apt install -y curl gpg
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg;
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null;
RUN apt update && apt install -y gh;

COPY . .

RUN cargo build --release

ENV RELEASE_GENERATOR_BIN "./target/release/changelog-generator"

ENTRYPOINT ["sh", "entrypoint.sh"]
