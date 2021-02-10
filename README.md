## mini_invoicer v0.1
My Official Senior Project --> Mini Invoicer System repository

# Overview
## A system that manages Invoices + Receipts for small-medium businesses, using a web interface
### Motivation
* The system was designed to be used instead of hand-written, paper-based invoices & receipts
### Purpose
* Electronically created invoices & receipts are much FASTER to instantiate & drastically LESS PRONE to ERRORS

## Functional Features
* CRUD Invoice | Payment Type
* CRUD Receipt
* CRUD Product | Brand | Category | Pricing
* CRUD Employee | Role
* CRUD Customer

## Non-functional Features
### Security
* Authentication (Cookie-based)
* Role-based Authorization | Least-privilege
* Anti-forgery tokens | Anti CSRF (Form-embedded)
* Anti SQL Injection
* ...to be continued
### Performance
* .Net5 Runtime
* SPA
* No sessions
* ...to be continued
### UX
* Intuitive, simple & very easy to use
* ...to be continued

## Monolith Architecture
* No CI/CD for now...
* Local development only for now...
* No tests written for now...

## Tech Stack
* Backend: ASP | .Net5 | RESTful
* Frontend: BlazorWASM | Bootstrap | Razor
* DB: SQL Server
* ORM: Entity Framework Core
* Auth: Identity Framework
* VC: Git

## Development Tools 
* IDE: JetBrains Rider
* DB Studio: SSMS
* Diagrams: app.diagrams.net
* API: Postman

### Remarks
* Started off as a simple mock project
* Refactored into a cleaner architecture (Core, App, Infrastructure, Presentation Layers)

### Future
* JWT
* Mobile-first frontend (Flutter)
* Serverless variation
* GCP
* Backend literally re-written in Golang.
