//HTTP URLS
Uri get_appointments_url = Uri.parse('http://10.0.2.2:5000/getappointments');
Uri profile_url = Uri.parse('http://10.0.2.2:5000/profile');
Uri search_url = Uri.parse('http://10.0.2.2:5000/search');
Uri bookappointment_url = Uri.parse('http://10.0.2.2:5000/bookapointment');
Uri login_url = Uri.parse('http://10.0.2.2:5000/login');
Uri register_url = Uri.parse('http://10.0.2.2:5000/register');
Uri addcomment_url = Uri.parse('http://10.0.2.2:5000/addcomment');

class AppointmentsList {
  int appointment_no;
  String doctor;
  String qualification;
  String hospital;
  String date;

  AppointmentsList(this.appointment_no, this.doctor, this.qualification,
      this.hospital, this.date);
}

class ProfileDetails {
  String name;
  String email;
  String phone_no;
  ProfileDetails(this.name, this.phone_no, this.email);
}

class SearchDetails {
  String designation;
  String name;
  String hospital_name;
  String doctor_id;

  SearchDetails(
      this.name, this.designation, this.hospital_name, this.doctor_id);
}

class Doctorprofile {
  String designation;
  String name;
  String hospital_name;
  String phone_no;
  String email;
  List comments;
  Doctorprofile(this.name, this.hospital_name, this.designation, this.phone_no,
      this.email, this.comments);
}

class PatientDetails {
  int appointment_no;
  String name;
  String phone_no;
  String date;
  PatientDetails(this.appointment_no, this.name, this.phone_no, this.date);
}
