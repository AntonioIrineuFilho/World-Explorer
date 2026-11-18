import Router from 'express'
import UserController from '../controllers/UserController'
import { schemaValidator } from '../middlewares/schemaValidator'
import { userCreateSchema } from '../schemas/userSchemas/userCreateSchema'
import { userAuthSchema } from '../schemas/userSchemas/userAuthSchema'

const router = Router()

router.post('/register', schemaValidator(userCreateSchema), UserController.create)
router.post('/login', schemaValidator(userAuthSchema), UserController.authenticate)

export default router