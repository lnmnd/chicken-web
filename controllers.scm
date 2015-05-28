(module
    controllers
    (main-page item-page about-page)
  (import chicken scheme)
  (use (only data-structures conc))
  (use (only ports with-output-to-string))
  (use (only utils read-all))
  (use (only spiffy send-response))
  (use (only sxml-transforms SXML->HTML))

  ;; sxml-> string
  (define (build-page content)
    (with-output-to-string
      (lambda ()
	(SXML->HTML
	 `(html (head
		 (style ,(read-all "style.css")))
		(body
		 (head (strong "chicken web") ": " (a (@ (href "/")) "index")
		       " "
		       (a (@ (href "/about")) "about"))
		 ,content))))))

  ;; sxml -> response
  (define (sxml->response sxml)
    (send-response
     body: (build-page sxml)))

  (define-syntax page
    (syntax-rules ()
      ((_ name args body)
       (define (name)
	 (lambda args
	   (sxml->response body))))))
  
  (define (li-item x)
    `(li (a (@ (href ,(conc "/item/" x))) ,x)))

  (page main-page (c)
	(let ((items '(1 2 3 4)))
	  `(div (h2 "main page")
		(ul ,(map li-item items)))))

  (page item-page (c item)
	`(div (h2 (conc "item " ,item))
	      (p "item stuff")))

  (page about-page (c)
	`(div (h2 "about page")
	      (p "about stuff")))

  )
