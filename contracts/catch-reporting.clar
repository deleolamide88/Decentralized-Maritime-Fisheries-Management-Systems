;; Catch Reporting Contract
;; Records fishing catches and validates against quotas

(define-constant ERR_UNAUTHORIZED (err u200))
(define-constant ERR_INVALID_VESSEL (err u201))
(define-constant ERR_INVALID_CATCH (err u202))
(define-constant ERR_CATCH_NOT_FOUND (err u203))

;; Catch report structure
(define-map catch-reports
  { report-id: uint }
  {
    vessel-id: uint,
    reporter: principal,
    fish-species: (string-ascii 50),
    catch-weight: uint,
    catch-location: (string-ascii 100),
    catch-date: uint,
    verified: bool
  }
)

;; Track report count
(define-data-var report-counter uint u0)

;; Submit catch report
(define-public (submit-catch-report
  (vessel-id uint)
  (fish-species (string-ascii 50))
  (catch-weight uint)
  (catch-location (string-ascii 100)))
  (let ((report-id (+ (var-get report-counter) u1)))
    (asserts! (> catch-weight u0) ERR_INVALID_CATCH)
    (map-set catch-reports
      { report-id: report-id }
      {
        vessel-id: vessel-id,
        reporter: tx-sender,
        fish-species: fish-species,
        catch-weight: catch-weight,
        catch-location: catch-location,
        catch-date: block-height,
        verified: false
      }
    )
    (var-set report-counter report-id)
    (ok report-id)
  )
)

;; Get catch report
(define-read-only (get-catch-report (report-id uint))
  (map-get? catch-reports { report-id: report-id })
)

;; Verify catch report (for authorized verifiers)
(define-public (verify-catch-report (report-id uint))
  (match (map-get? catch-reports { report-id: report-id })
    report-data
    (begin
      (map-set catch-reports
        { report-id: report-id }
        (merge report-data { verified: true })
      )
      (ok true)
    )
    (err ERR_CATCH_NOT_FOUND)
  )
)

;; Get total catch by species
(define-read-only (get-total-catch-by-species (species (string-ascii 50)))
  ;; This would require iteration in a real implementation
  ;; For simplicity, returning a placeholder
  (ok u0)
)
