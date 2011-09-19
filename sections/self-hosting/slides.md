!SLIDE title-slide bullets
# Self-Hosting #

* A computer program that produces new versions of that same program
* Compilers, kernels, revision control software

!SLIDE title-slide bullets
# Self-Hosting #
## Applies to services? ##
<p class="notes">WTF MATE??</p>

!SLIDE center
# Heroku Self-Hosting: Easy #
## www.heroku.com ##
## blog.heroku.com ##
![Heroku Website](public.png "Heroku Website")

!SLIDE
# Motivations #
* Dogfooding
* Efficiency
* Decrease surface area
* Separation of concerns

<p class="notes">
Used to be unified with API!
</p>

!SLIDE commandline
# Heroku Self-Hosting: Normal #
## addons.heroku.com ##
## Cron ##

    $ heroku ps --app cron
    Process       State               Command
    ------------  ------------------  --------------------------------------------------
    exec.1        up for 19h          rake resque:work QUEUE=exec
    exec.2        up for 19h          rake resque:work QUEUE=exec
    finder.1      up for 19h          rake resque:work QUEUES=scheduled,missed
    finder.2      up for 18h          rake resque:work QUEUES=scheduled,missed
    scheduler.1   up for 19h          rake resque:scheduler
    web.1         up for 19h          bundle exec unicorn -p $PORT -c ./unicorn.conf.rb
    web.2         up for 19h          bundle exec unicorn -p $PORT -c ./unicorn.conf.rb

!SLIDE
# Heroku Self-Hosting: Heroic #
* PGBackups
* postgres.heroku.com
* Manages entire Database Cloud from heroku apps

<p class="notes">
TODO: postgres.heroku.com image
</p>

!SLIDE
# Heroku Self-Hosting: Legendary? #

!SLIDE center
# Architecture #
![Heroku Black Box Architecture](Heroku Black Box.png "Heroku Black Box Architecture")

!SLIDE center
# Self-Hosted Architecture #
![Compile / Runtime](Compile To Runtime.png "Compile To Runtime")

!SLIDE
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
# Operations #
* Heroku proves servers suck
* Git push heroku master deploys
* heroku logs --tail logging

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