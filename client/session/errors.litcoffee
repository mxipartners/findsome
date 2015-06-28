Local (client-only) collection for keeping track of errors.

    @Errors = new Mongo.Collection null

    @throwError = (message) -> Errors.insert {message: message}
