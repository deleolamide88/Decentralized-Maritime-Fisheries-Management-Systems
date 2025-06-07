;; Sustainability Monitoring Contract
;; Monitors fishing sustainability metrics and environmental impact

(define-constant ERR_UNAUTHORIZED (err u400))
(define-constant ERR_INVALID_DATA (err u401))
(define-constant ERR_REPORT_NOT_FOUND (err u402))

;; Sustainability metrics structure
(define-map sustainability-reports
  { report-id: uint }
  {
    vessel-id: uint,
    reporter: principal,
    fish-species: (string-ascii 50),
    fishing-method: (string-ascii 50),
    bycatch-amount: uint,
    habitat-impact-score: uint,
    report-date: uint,
    compliance-status: bool
  }
)

;; Species sustainability status
(define-map species-status
  { species: (string-ascii 50) }
  {
    conservation-status: (string-ascii 20),
    population-trend: (string-ascii 20),
    last-assessment: uint,
    is-protected: bool
  }
)

;; Track report count
(define-data-var sustainability-counter uint u0)

;; Submit sustainability report
(define-public (submit-sustainability-report
  (vessel-id uint)
  (fish-species (string-ascii 50))
  (fishing-method (string-ascii 50))
  (bycatch-amount uint)
  (habitat-impact-score uint))
  (let ((report-id (+ (var-get sustainability-counter) u1)))
    (asserts! (<= habitat-impact-score u10) ERR_INVALID_DATA)
    (map-set sustainability-reports
      { report-id: report-id }
      {
        vessel-id: vessel-id,
        reporter: tx-sender,
        fish-species: fish-species,
        fishing-method: fishing-method,
        bycatch-amount: bycatch-amount,
        habitat-impact-score: habitat-impact-score,
        report-date: block-height,
        compliance-status: (<= habitat-impact-score u5)
      }
    )
    (var-set sustainability-counter report-id)
    (ok report-id)
  )
)

;; Set species conservation status
(define-public (set-species-status
  (species (string-ascii 50))
  (conservation-status (string-ascii 20))
  (population-trend (string-ascii 20))
  (is-protected bool))
  (begin
    (map-set species-status
      { species: species }
      {
        conservation-status: conservation-status,
        population-trend: population-trend,
        last-assessment: block-height,
        is-protected: is-protected
      }
    )
    (ok true)
  )
)

;; Get sustainability report
(define-read-only (get-sustainability-report (report-id uint))
  (map-get? sustainability-reports { report-id: report-id })
)

;; Check species protection status
(define-read-only (is-species-protected (species (string-ascii 50)))
  (match (map-get? species-status { species: species })
    status-data (ok (get is-protected status-data))
    (ok false)
  )
)

;; Calculate vessel sustainability score
(define-read-only (get-vessel-sustainability-score (vessel-id uint))
  ;; Simplified calculation - in reality would aggregate multiple reports
  (ok u7)
)
