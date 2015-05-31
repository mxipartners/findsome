# Local (client-only) collection
@Errors = new Mongo.Collection null

@throwError = (message) -> Errors.insert {message: message}
