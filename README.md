# fempinya3_flutter_app

A new Flutter project.

## Log in to app with mocked users

Mocked users are created with the following credentials :

    mail: "mail@mail.com"
    password: "password"

Use these credentials, otherwise you will get authentication errors.

## TO DOCUMENT SOMEWHERE

### Nullables in bloc states
Do not set properties in the bloc state as null after initialization. The reason is that, when calling copyWith(), if it's not specifically passed, the value will be null. Hence you don't know if the value is null because the intention is to change some other property, or because we want to set it to null.

To avoid this situation, you can have a boolean next to the value to enable/disable the functionality. For example a filter dayFilter has dayFilterEnabled next to it.

## API Specifications for Endpoints `/rondes`, `/ronda`, and `/publicDisplayUrl`
===========================================================

### Endpoint: `/rondes`

#### Method: `GET`

#### Description:
Returns a list of rondes for a given user email.

#### Request Parameters:

* `email`: The user's email address (required)

#### Response:

* `200 OK`: The list of rondes for the given user email.
* `400 Bad Request`: The request is missing the required `email` parameter or the parameter is null.

#### Response Body:

* A list of ronda objects, each containing:
	+ `id`: The ID of the ronda.
	+ `eventName`: The name of the event.
	+ `publicUrl`: The public URL of the ronda.
	+ `ronda`: The ronda number.

#### Example Response:
```json
[
  {
    "id": 0,
    "eventName": "Lorem ipsum dolor",
    "publicUrl": "https://app.fempinya.cat/public/display/AireNou/WWN5Wk9aTnl4Q3FHUTE5bklsTkdCOFEvQ1BLWVB4M1BveVpRYlNJbkE1bDZ2SVBNTUlIbzI3S1RXUGRlVlBsUQ==",
    "ronda": 0
  },
  {
    "id": 1,
    "eventName": "Lorem ipsum dolor",
    "publicUrl": "https://app.fempinya.cat/public/display/AireNou/WWN5Wk9aTnl4Q3FHUTE5bklsTkdCOFEvQ1BLWVB4M1BveVpRYlNJbkE1bDZ2SVBNTUlIbzI3S1RXUGRlVlBsUQ==",
    "ronda": 1
  },
  {
    "id": 2,
    "eventName": "sit amet.",
    "publicUrl": "",
    "ronda": 2
  },
  {
    "id": 3,
    "eventName": "Sed quisquam",
    "publicUrl": "mail@mail.com",
    "ronda": 3
  }
]
```

### Endpoint: `/ronda`

#### Method: `GET`

#### Description:
Returns a single ronda by ID.

#### Request Parameters:

* `id`: The ID of the ronda (required)

#### Response:

* `200 OK`: The ronda with the given ID.
* `400 Bad Request`: The request is missing the required `id` parameter or the parameter is null.
* `404 Not Found`: The ronda with the given ID was not found.

#### Response Body:

* A ronda object, containing:
	+ `id`: The ID of the ronda.
	+ `eventName`: The name of the event.
	+ `publicUrl`: The public URL of the ronda.
	+ `ronda`: The ronda number.

#### Example Response:
```json
{
  "id": 0,
  "eventName": "Lorem ipsum dolor",
  "publicUrl": "https://app.fempinya.cat/public/display/AireNou/WWN5Wk9aTnl4Q3FHUTE5bklsTkdCOFEvQ1BLWVB4M1BveVpRYlNJbkE1bDZ2SVBNTUlIbzI3S1RXUGRlVlBsUQ==",
  "ronda": 0
}
```

### Endpoint: `/publicDisplayUrl`

#### Method: `GET`

#### Description:
Returns the public display URL for a given user email.

#### Request Parameters:

* `email`: The user's email address (required)

#### Response:

* `200 OK`: The public display URL for the given user email.
* `400 Bad Request`: The request is missing the required `email` parameter or the parameter is null.
* `404 Not Found`: The user email is unknown.

#### Response Body:

* `publicUrl`: The public display URL for the given user email.

#### Example Response:
```json
{
  "publicUrl": "https://app.fempinya.cat/public/display/AireNou/WWN5Wk9aTnl4Q3FHUTE5bklsTkdCOFEvQ1BLWVB4M1BveVpRYlNJbkE1bDZ2SVBNTUlIbzI3S1RXUGRlVlBsUQ=="
}
```

