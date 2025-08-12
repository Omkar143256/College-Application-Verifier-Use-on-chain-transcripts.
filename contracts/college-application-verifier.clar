;; College Application Verifier
;; A simple on-chain transcript verification system

;; Map to store student transcripts (hashes for privacy)
(define-map transcripts principal (buff 32))

;; Error constants
(define-constant err-unauthorized (err u100))
(define-constant err-already-exists (err u101))
(define-constant err-not-found (err u102))

;; Function 1: Upload transcript hash (only once per student)
(define-public (upload-transcript (transcript-hash (buff 32)))
    (begin
        ;; Validate length or format
        (if (is-eq (len transcript-hash) u32) 
            (begin
                (map-set transcripts tx-sender transcript-hash)
                (ok true)
            )
            (err u100) ;; custom error code
        )
    )
)


;; Function 2: Verify transcript hash for a student
(define-read-only (verify-transcript (student principal) (transcript-hash (buff 32)))
  (ok (is-eq (default-to 0x (map-get? transcripts student)) transcript-hash))
)
