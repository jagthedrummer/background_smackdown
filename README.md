# Background Smackdown


Running resque workers

    $ COUNT=8 QUEUE=* rake resque:workers

Running sidekiq workers
    $ sidekiq -c 8
