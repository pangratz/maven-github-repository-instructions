---
title: Template for a Maven Project with a built in Maven Repository hosted on GitHub
layout: default
---

# Template for a Maven Project with a built in Maven Repository hosted on GitHub

This template configures your Maven project so your builds (snapshots and releases) are deployed to
a Maven Repository hosted inside the GitHub repository of the project. The Maven Repository makes use
of the neat GitHub pages feature, and therefore the binaries are located in the `gh-pages` branch of your project.

## Modify the contents of your projects' pom.xml

1. add the following properties and fill in your GitHub username and the name of the project on GitHub

		<properties>
			...
			<gitUser>YOUR_GIT_USERNAME</gitUser>
			<gitProject>YOUR_PROJECT_NAME_ON_GITHUB</gitProject>
			<scmUrl>scm:git:git@github.com:${gitUser}/${gitProject}.git</scmUrl>
			<altDeploymentRepository>release-repo::default::file:../../repository/releases</altDeploymentRepository>
			...
		</properties>
		
2. add `scm` information

		<scm>
			<connection>${scmUrl}</connection>
			<url>${scmUrl}</url>
			<developerConnection>${scmUrl}</developerConnection>
		</scm>
		
3. add a `deploy-snapshot` profile

		<profiles>
			<profile>
				<id>deploy-snapshot</id>
				<properties>
					<altDeploymentRepository>snapshot-repo::default::file:repository/snapshots</altDeploymentRepository>
				</properties>
			</profile>
		</profiles>
		
4. download the scripts [deploySnapshot.sh](deploySnapshot.sh) and [deployVersion.sh](deployVersion.sh) into the root folder of your Maven project


## Release a new version or snapshot

execute either
	
	./deploySnapshot.sh

or 

	./deploySnapshot.sh


## Use the project files as dependency in other Maven projects

add your projects' maven repository and replace `YOUR_GITHUB_USER_NAME` with your, you guessed it, GitHub user
name and `YOUR_PROJECT_NAME_ON_GITHUB` with the name of the project on GitHub.

	<repositories>
		...
		<repository>
		    <id>YOUR_GITHUB_USER_NAME-mvn-repo-releases</id>
		    <url>http://YOUR_GITHUB_USER_NAME.github.com/YOUR_PROJECT_NAME_ON_GITHUB/releases</url>
		</repository>
		<!-- remove the following repository if you don't want to use snapshot releases -->
		<repository>
		    <id>YOUR_GITHUB_USER_NAME-mvn-repo-snapshots</id>
		    <url>http://YOUR_GITHUB_USER_NAME.github.com/YOUR_PROJECT_NAME_ON_GITHUB/snapshots</url>
		</repository>
		...
	</repositories>


now you can add your previous released project as a dependency

	<dependencies>
		...
		<dependency>
		    <groupId> ... </groupId>
		    <artifactId> ... </artifactId>
		    <version> ... </version>
		</dependency>
		...
	</dependencies>




