# Personal Site

This is a repo for my personal portfolio site. The site is built with [Hugo](https://gohugo.io/) and uses Docker for local development (no local Hugo installation required).

See site-infra for hosting. This repo contains the content and build configuration.

## Project Structure

```
.
├── hugo-site/              # Hugo site
│   ├── config.toml         # Site configuration
│   ├── content/            # Site content
│   ├── data/               # Data files (work experience, projects)
│   │   ├── work.yaml
│   │   └── projects.yaml
│   └── themes/portfolio/   # Custom theme
│       ├── layouts/        # HTML templates
│       └── static/         # CSS, images, etc.
└── Makefile               # Build commands
```

## Getting Started

All commands use Docker, so you don't need Hugo installed locally. Just Docker!

### Available Commands

```bash
make help           # Show all available commands
make docker-build   # Build the Hugo Docker image
make build          # Build the site (output in hugo-site/public/)
make serve          # Serve the site locally at http://localhost:1313
make clean          # Clean build artifacts
make clean-all      # Clean build artifacts and Docker image
```

### Development Workflow

1. **Start the development server:**
   ```bash
   make serve
   ```
   This will start Hugo's development server at `http://localhost:1313` with live reload enabled.

2. **Make your changes:**
   - Edit content in `hugo-site/data/` (work experience, projects)
   - Edit configuration in `hugo-site/config.toml`
   - Edit templates in `hugo-site/themes/portfolio/layouts/`
   - Edit styles in `hugo-site/themes/portfolio/static/css/`

3. **The browser will automatically reload** when you save changes

4. **Build for production:**
   ```bash
   make build
   ```
   The static site will be generated in `hugo-site/public/`

## Adding Content

### Work Experience

Edit `hugo-site/data/work.yaml`:

```yaml
- title: "Company Name"
  duration: "2024 - Present"
  description: "Description of your role and achievements"
```

### Personal Projects

Edit `hugo-site/data/projects.yaml`:

```yaml
- title: "Project Name"
  type: "Project Type"
  description: "Description of the project"
```

### Site Configuration

Edit `hugo-site/config.toml` to change:
- Site title and metadata
- Social media links (LinkedIn, GitHub)
- About section text

## Theme Features

The custom portfolio theme includes:
- Responsive design (mobile, tablet, desktop)
- Dark mode support (automatically follows system preference)
- Clean, minimal design
- SEO-friendly meta tags
- Semantic HTML structure

## Docker Setup

The site uses a custom Docker image built on official Debian base image with Hugo installed from Debian repositories.

- **Base image**: `debian:trixie-slim` (official Debian image)
- **Hugo version**: v0.131.0+extended (from Debian Trixie repositories)
- **Build**: `make docker-build` or automatic when running `make build` or `make serve`

### Hugo Version Management

The Hugo version is determined by the Debian Trixie package repository. The current version (0.131.0+extended) is documented in the Dockerfile's `HUGO_VERSION` build argument. This ensures version visibility for development and deployment alignment.

To use a different Hugo version, you would need to either:
- Wait for Debian package updates
- Use a different Debian release (e.g., switch to unstable/sid)
- Modify the Dockerfile to use an alternative installation method

No local installation of Hugo is required. The Docker image is built locally on first use.
