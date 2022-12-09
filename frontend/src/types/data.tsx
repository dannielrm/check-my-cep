export interface IAddress {
  id?: number;
  zip: string;
  invalid_zip: boolean;
  street_name?: string;
  neighborhood?: string;
  city?: string;
  state?: string;
}

export interface ICustomer {
  id?: number;
  name: string;
  addresses?: IAddress[];
}