# Background Smackdown


Running resque workers

    $ INTERVAL=0.1 COUNT=8 QUEUE=* rake resque:workers

Running sidekiq workers
    $ sidekiq -c 8
