import type { Request, Response, NextFunction } from 'express'
import type { ZodType } from 'zod'
import { ZodError } from 'zod'

export const schemaValidator = (schema: ZodType) => {
    return (req: Request, res: Response, next: NextFunction) => {
        try {
            req.body = schema.parse(req.body)
            next()
        } catch (error) {
            if (error instanceof ZodError) return res.status(400).json({"message": "ERRO AO VALIDAR CAMPOS DO BODY", "error": error.issues})
            return res.status(400).json({"message": "ERRO AO VALIDAR CAMPOS DO BODY", "error": error})  
        }
    }
} 