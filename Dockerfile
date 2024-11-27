FROM golang:1.23 as builder

WORKDIR /build

COPY . .
RUN go mod download 
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /parcel_app

FROM alpine:3.20

COPY --from=builder build/tracker.db ./
COPY --from=builder parcel_app ./
CMD ["/parcel_app"]