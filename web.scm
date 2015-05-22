(use (only spiffy vhost-map start-server))
(use (only spiffy-uri-match uri-match/spiffy))

(load "controllers")
(import (only controllers main-page item-page about-page))

(let* ((port (string->number (get-environment-variable "PORT"))))
  (vhost-map `((".*" . ,(uri-match/spiffy
			 `(((/ "")
			    (GET ,(main-page)))
			   ((/ "item" "(.+)")
			    (GET ,(item-page)))
			   ((/ "about")
			    (GET ,(about-page))))))))

  (start-server port: port))

