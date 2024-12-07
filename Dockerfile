FROM node:23-alpine AS client

WORKDIR /frontend
COPY client/package.json client/package-lock.json ./
RUN npm install
COPY client .
RUN npm run build


FROM golang:1.23-alpine AS server

WORKDIR /backend
COPY go.mod go.sum ./
RUN go mod download
COPY server .
COPY --from=client /frontend/dist /backend/public
RUN go build -o owlchest .


FROM alpine:latest AS monolithic

WORKDIR /root/
COPY --from=server /backend/owlchest .
COPY --from=server /backend/public ./public
EXPOSE 8080
CMD [ "./owlchest" ]