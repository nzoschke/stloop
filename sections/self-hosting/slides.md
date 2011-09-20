!SLIDE title-slide bullets incremental
# Self-Hosting #
## A computer program that produces new versions of that same program ##

* Compilers
* Kernels
* Programming Languages
* Revision Control Systems
* Text Editors

<p class="notes">
FASM; Haiku; GCC; Hart/Levin Lisp in '62; PyPy; Rubinius; CoffeeScript; Git; VIM
</p>

!SLIDE title-slide bullets
# Self-Hosting #
## Applicable Metaphor for Services? ##
<p class="notes">Service != computer program, but is a comparable system</p>

!SLIDE center
# Heroku Self-Hosting: Easy #
## www.heroku.com ##
## blog.heroku.com ##
![Heroku Website](public.png "Heroku Website")

!SLIDE bullets
# Motivations #
* Dogfooding
* Efficiency
* Separation of Concerns

<p class="notes">
Used to be unified with API!
</p>

!SLIDE commandline
# Heroku Self-Hosting: Normal #
## addons.heroku.com ##
## Cron Addon ##

    $ heroku ps --app cron
    Process       State        Command
    ------------  ---------  --------------------------------------------------
    exec.1        up for 9d  rake resque:work QUEUE=exec
    exec.2        up for 9d  rake resque:work QUEUE=exec
    finder.1      up for 9d  rake resque:work QUEUES=scheduled,missed
    finder.2      up for 8d  rake resque:work QUEUES=scheduled,missed
    scheduler.1   up for 9d  rake resque:scheduler
    web.1         up for 9d  bundle exec unicorn -p $PORT -c ./unicorn.conf.rb
    web.2         up for 9d  bundle exec unicorn -p $PORT -c ./unicorn.conf.rb

<p class="notes">
Addons split off from API too. Cron built using addons APIs.
</p>

!SLIDE smbullets center
# Heroku Self-Hosting: Heroic #
## Database Cloud Built with Heroku Apps #
## Shogun / PGBackups ##
![Heroku PostgreSQL](postgres.png "Heroku PostgreSQL")

<p class="notes">
postgres.heroku.com too
</p>

!SLIDE
# Heroku Self-Hosting: Legendary? #

<p class="notes">
Halo difficulty levels
</p>

!SLIDE center
# Heroku Architecture #
![Heroku Black Box Architecture](Heroku Black Box.png "Heroku Black Box Architecture")

!SLIDE center
# Self-Hosted Architecture #
![Compile / Runtime](Compile To Runtime.png "Compile To Runtime")

<p class="notes">
Compiling in a dyno remind you of the LLVM demo?
</p>

!SLIDE bullets
# Motivations #
* Dogfooding
* Efficiency
* Decrease surface area
* Separation of concerns

<p class="notes">
Less surface area == more secure
Same bullets as public.heroku.com. Pattern?
</p>

!SLIDE
# Disregard Servers #

!SLIDE
# Disregard Servers, #
# Acquire Dynos #

!SLIDE
# Disregard Servers, #
# Acquire Dynos, #
# Not Just for Rails Apps #

!SLIDE smbullets
# Operations #
* git push heroku master deploys
* secure containers
* ephemeral containers
* effortless scaling
* addons
* logging

!SLIDE center
# What Else? #
![Heroku Black Box Architecture](Heroku Black Box.png "Heroku Black Box Architecture")

<p class="notes">
API is just a Rails app
Could Router?
DB (postgres) Process
Message Bus (rabbitmq, redis) Process
</p>

!SLIDE
# Challenges #
* Circular Dependencies

!SLIDE commandline
# Runtime Primatives #
## Processes ##
    $ heroku help ps
    Usage: heroku ps

     list processes for an app

    Additional commands, type "heroku help COMMAND" for more details:

      ps:scale PROCESS1=AMOUNT1 ...  # scale processes by the given amount
      ps:restart [PROCESS]           # restart an app process
      ps:run COMMAND                 # run an attached process
      ps:kill [SIGNAL] PROCESS       # send a signal to an app process

!SLIDE commandline
# Runtime Primatives #
## Releases ##
    $ heroku help releases
    Usage: heroku releases

     list releases

    Additional commands, type "heroku help COMMAND" for more details:

      releases:info RELEASE  # view detailed information for a release
      rollback [RELEASE]     # roll back to an older release


!SLIDE
* Codon - Compiles in a heroku app
* Performs slug compiles in a heroku app

Primatives
Circular dependencies
CGF

!SLIDE
* PSMgr
* API

!SLIDE smbullets
# Definition #
kernels, assemblers, shells, revision control software
Lets add "platform" to that list!
Self-hosting to services -- different but related problem

!SLIDE smbullets
# Simple Examples #
heroku.com - public.heroku.com heroku app
blog.heroku.com - 
addons.heroku.com - API access this on boot
pgbackups
ion

!SLIDE smbullets
# More Examples #
shogun - database service that hosts its own database
codon - 
psmgr - Manages processes and manages itself. 2 running bootstrap
local psmgr
  bootstrap 1st heroku app
  use tht to run 2nd heroku app

!SLIDE smbullets
# service bootstrapping #
Infrastructure cloud

!SLIDE smbullets
# Holy Grail #
Everything on runtime.