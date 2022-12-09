import { Card } from 'react-bootstrap';
import { ICustomer } from '../types/data';
import { IAddress } from '../types/data';

export const WithValidZip = (props: IAddress) => (
  <p>
    {props.zip}, {props.street_name}, {props.neighborhood}, {props.city}, {props.state}
  </p>
)

export const WithInvalidZip = (props: IAddress) => (
  <p> INVALID ZIP CODE: {props.zip} </p>
)

export const Customer = (props: ICustomer) => (
  <>
    <Card>
      <h2>{props.name}</h2>
      {props.addresses?.map( (address) =>
        address.invalid_zip ? WithInvalidZip(address) : WithValidZip(address)
      )}
    </Card>
  </>
)