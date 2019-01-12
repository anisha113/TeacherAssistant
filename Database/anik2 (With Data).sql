-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Dec 28, 2016 at 09:16 PM
-- Server version: 10.1.13-MariaDB
-- PHP Version: 5.6.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `anik2`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddAdditionalUserData` (IN `Puserid` VARCHAR(256), IN `Pfirstname` VARCHAR(50), IN `Plastname` VARCHAR(50), IN `Psex` INT(3), IN `Pversitydeptid` INT)  NO SQL
UPDATE users SET users.FirstName = pfirstname,
                 users.lastname = plastname,
                 users.sex = psex,
                 users.versityDeptId = Pversitydeptid 
                 where users.id = puserid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AddAttendance` (IN `mrid` INT(11), IN `date` DATE, IN `pr` TINYINT(1))  NO SQL
INSERT INTO attendence VALUES (null, mrid, date, pr)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AddAttendanceSection` (IN `tcid` INT(11), IN `start` INT(11), IN `end` INT(11), IN `mark` INT(11), IN `default` BOOLEAN)  NO SQL
INSERT INTO attendencesection VALUES(null, start, end, mark, tcid, default)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AddCource` (IN `prefix` TEXT, IN `cno` INT(11), IN `postfix` TEXT, IN `ct` TEXT, IN `vdid` INT(11), IN `crd` FLOAT(11))  NO SQL
INSERT INTO course VALUES(null, prefix, cno, postfix, ct, vdid, crd)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AddDegreeSessionYearTerm` (IN `did` INT(11), IN `sid` INT(11), IN `yid` INT(11), IN `tid` INT(11))  NO SQL
INSERT INTO degreesessionyearterm VALUES(null, did, sid, yid, tid)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AddMark4attByMsidSid` (IN `mcid` INT(11), IN `sid` VARCHAR(16))  NO SQL
INSERT INTO mark VALUES(null, mcid, sid, null)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AddMark4CtAssByMsidSid` (IN `msid` INT(11), IN `sid` INT(11))  NO SQL
INSERT INTO mark VALUES(null, msid, sid, null)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AddMarksectionForAss` (IN `tcid` INT(11), IN `snid` INT(11), IN `msmark` INT(11))  NO SQL
INSERT INTO marksection VALUES(null, tcid, snid, msmark)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AddMarkSectionForAttendance` (IN `tcid` INT(11))  NO SQL
INSERT INTO marksection VALUES (NULL, tcid, 1, 10)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AddMarksectionForCt` (IN `tcid` INT(11), IN `snid` INT(11), IN `msmark` INT(11))  NO SQL
INSERT INTO marksection VALUES (null, tcid, snid, msmark)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AddSectionName` (IN `name` TEXT)  NO SQL
INSERT INTO sectionname VALUES(null,name)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `addStudent` (IN `sid` VARCHAR(256), IN `btc` TEXT, IN `uid` VARCHAR(256))  NO SQL
INSERT INTO student VALUES(null, sid, btc, uid)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AddStudentUserCourse` (IN `tcid` INT(11), IN `sid` INT(11))  NO SQL
INSERT INTO `studentusercourse` (`id`, `teachercourseid`, `studentid`, `isconfirmed`) VALUES (NULL, tcid, sid, '0')$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `addTeacher` (IN `UId` VARCHAR(128), IN `did` INT, IN `sid` INT)  NO SQL
INSERT INTO teacher VALUES(null, Uid, did, sid)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AddTeacherCource` (IN `uid` INT(11), IN `did` INT(11), IN `cid` INT(11))  NO SQL
INSERT INTO teachercourse VALUES(null, uid, did, cid, 0)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ClosedTeacherCourseByTidCid` (IN `tid` INT(11), IN `cid` INT(11))  NO SQL
UPDATE teachercourse SET teachercourse.isclosed = 1
WHERE teachercourse.teacherId=tid
AND teachercourse.courseId =cid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CountAttendanceSectionIdByTcid` (IN `tcid` INT(11))  NO SQL
SELECT COUNT(attendencesection.id) FROM attendencesection 
WHERE attendencesection.teacherCourceId = tcid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CountAttendanceSectionIdByTcidAsDefault` (IN `tcid` INT(11))  NO SQL
SELECT COUNT(attendencesection.id) FROM attendencesection 
WHERE attendencesection.teacherCourceId = tcid	
AND attendencesection.asDefault = 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `countCtAssByTCID` (IN `tcid` INT(11))  NO SQL
select COUNT(marksection.id) FROM marksection 
WHERE marksection.sectionNameId != 1
AND marksection.teacherCourseId = tcid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CountStudentsByTCID` (IN `tcid` INT(11))  NO SQL
SELECT COUNT(studentusercourse.id) FROM studentusercourse 
WHERE studentusercourse.teachercourseid = tcid
AND studentusercourse.isconfirmed = 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteMarkByMsidSid` (IN `msid` INT(11), IN `sid` INT(11))  NO SQL
DELETE FROM mark 
WHERE mark.markSectiontId = msid
AND mark.studentId = sid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteStudentCourseBySCID` (IN `scid` INT(11))  NO SQL
DELETE FROM studentusercourse WHERE studentusercourse.id = scid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DeletTeachCourseByTcid` (IN `Tcid` INT(11))  NO SQL
DELETE FROM teachercourse WHERE teachercourse.id = tcid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GeAllDatesPresentsByTcidSid` (IN `tcid` INT(11), IN `sid` INT(11))  NO SQL
SELECT attendence.date as dateColumn, attendence.present FROM attendence
INNER JOIN mark on mark.id =attendence.markId
INNER JOIN marksection on marksection.id = mark.markSectiontId
WHERE marksection.teacherCourseId = tcid
AND mark.studentId = sid
ORDER BY dateColumn$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllCourselListByUserId` (IN `uid` VARCHAR(256))  NO SQL
SELECT teachercourse.id, course.prefix, course.course_no, course.course_tittle, course.postfix, teachercourse.isclosed, session.session FROM teachercourse
INNER JOIN course on teachercourse.courseId = course.id
INNER JOIN degreesessionyearterm on teachercourse.DegreeSessionYearTermId = degreesessionyearterm.id
INNER JOIN session on degreesessionyearterm.sessionId = session.id
INNER JOIN teacher on teacher.id = teachercourse.teacherId
WHERE teacher.UserId = uid
ORDER BY course.course_no$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllCrourseNameBySessionIDTeacherID` (IN `tid` INT(11), IN `sid` INT)  NO SQL
SELECT teachercourse.id, course.prefix, course.course_no, course.course_tittle, course.postfix FROM teachercourse
INNER JOIN degreesessionyearterm 
on degreesessionyearterm.id = teachercourse.DegreeSessionYearTermId
INNER JOIN session on session.id = degreesessionyearterm.sessionId
INNER JOIN course on course.id = teachercourse.courseId
WHERE session.id = sid AND teachercourse.teacherId = tid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllCtAssByTCID` (IN `tcid` INT(11))  NO SQL
SELECT marksection.id, marksection.sectionNameId, 
sectionname.name FROM marksection
INNER JOIN sectionname on marksection.sectionNameId = sectionname.id
WHERE marksection.sectionNameId != 1
AND marksection.teacherCourseId =tcid
ORDER BY marksection.sectionNameId$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllCtAssNameMarkByTcidSid` (IN `tcid` INT(11), IN `sid` INT(11))  NO SQL
SELECT marksection.sectionNameId, sectionname.name, mark.mark FROM marksection
INNER JOIN sectionname on sectionname.id = marksection.sectionNameId
INNER JOIN mark on mark.markSectiontId = marksection.id
WHERE marksection.teacherCourseId =tcid
AND marksection.sectionNameId != 1
AND mark.studentId = sid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllCTitleSessionBySID` (IN `sid` VARCHAR(128))  NO SQL
SELECT course.prefix, course.course_no, course.course_tittle, course.postfix, session.session, teachercourse.id FROM course
INNER JOIN teachercourse on teachercourse.courseId = course.id
INNER JOIN studentusercourse on 
studentusercourse.teachercourseid = teachercourse.id
INNER JOIN degreesessionyearterm on 
degreesessionyearterm.id = teachercourse.DegreeSessionYearTermId
INNER JOIN session on session.id = degreesessionyearterm.sessionId
WHERE studentusercourse.studentid = sid
AND studentusercourse.isconfirmed = 1
ORDER BY course.course_no$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllDept` ()  NO SQL
SELECT dept.id, dept.name FROM dept$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllDesignation` ()  NO SQL
SELECT designation.id, designation.designation as name from designation$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllDgree` ()  NO SQL
SELECT degree.id, degree.levelName FROM degree$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllSalutaion` ()  NO SQL
SELECT salutation.id,salutation.salutation as name FROM salutation$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllSession` ()  NO SQL
SELECT session.id, session.session FROM session$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllTerm` ()  NO SQL
SELECT term.id, term.term FROM term$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllVersity` ()  NO SQL
SELECT versity.id , versity.name FROM versity$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllYear` ()  NO SQL
SELECT year.id, year.year FROM year$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetApprovedStudentByTeacherCourseId` (IN `tcid` INT(11))  NO SQL
SELECT studentusercourse.id, student.studentId, users.FirstName, users.LastName FROM studentusercourse
INNER JOIN student on studentusercourse.studentid = student.id
INNER JOIN users on student.userid = users.Id
WHERE studentusercourse.teachercourseid = tcid
AND studentusercourse.isconfirmed = 1
ORDER BY student.studentId$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAttendanceAsdefaultBytcid` (IN `tcid` INT(11))  NO SQL
SELECT attendencesection.id FROM attendencesection
WHERE attendencesection.teacherCourceId =tcid
AND attendencesection.asDefault = 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAttendanceIdByMarkIdDate` (IN `mrid` INT(11), IN `dt` DATE)  NO SQL
SELECT attendence.id FROM attendence
WHERE attendence.markId = mrid AND attendence.date = dt LIMIT 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAttendanceMSIdSidByTCId` (IN `tcid` INT(11))  NO SQL
SELECT mark.id, mark.markSectiontId, mark.studentId, 
student.studentId as s FROM mark
INNER JOIN marksection on marksection.id = mark.markSectiontId
INNER JOIN student on 	student.id = mark.studentId
WHERE marksection.teacherCourseId = tcid
AND marksection.sectionNameId = 1
ORDER BY s$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAttendancePersentaheByTCID` (IN `tcid` INT(11))  NO SQL
SELECT marksection.sectionPercentage FROM marksection
WHERE marksection.sectionNameId = 1 AND
marksection.teacherCourseId = tcid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAttendanceSecListByTCID` (IN `tcid` INT(11))  NO SQL
SELECT ac.id, ac.start, ac.end, ac.mark FROM attendencesection as ac
WHERE ac.teacherCourceId = tcid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAttendanceSectionByTCID` (IN `tcid` INT(11))  NO SQL
SELECT attendancesection.numberOfSection FROM attendancesection WHERE attendancesection.teacherCourseId = tcid LIMIT 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAttMarkByTCID` (IN `tcid` INT(11))  NO SQL
SELECT marksection.sectionPercentage FROM marksection
WHERE marksection.sectionNameId = 1
AND marksection.teacherCourseId = tcid
LIMIT 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetBatchByUserId` (IN `uid` VARCHAR(256))  NO SQL
SELECT student.batch FROM student WHERE student.userid = uid LIMIT 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetClosedCrourseNameBySessionIDTeacherID` (IN `tid` INT(11), IN `sid` INT(11))  NO SQL
SELECT course.id, course.prefix, course.course_no, course.course_tittle, course.postfix FROM teachercourse
INNER JOIN degreesessionyearterm 
on degreesessionyearterm.id = teachercourse.DegreeSessionYearTermId
INNER JOIN session on session.id = degreesessionyearterm.sessionId
INNER JOIN course on course.id = teachercourse.courseId
WHERE session.id = sid AND teachercourse.teacherId = tid
AND teachercourse.isclosed = 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetCorseNameByStudentId` (IN `sid` INT(11))  NO SQL
SELECT sc.id, sc.isconfirmed, course.prefix, course.course_no, course.postfix, course.course_tittle FROM studentusercourse AS sc
INNER JOIN teachercourse on teachercourse.id = sc.teachercourseid
INNER JOIN course on course.id =teachercourse.courseId
WHERE sc.studentid = sid ORDER BY course.course_no$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetCourseByVersityDeptId` (IN `vdid` INT)  NO SQL
SELECT course.course_tittle, course.id FROM course WHERE course.versityDeptId = vdid ORDER BY course.course_no$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetCourseListByUserID` (IN `uid` VARCHAR(256))  NO SQL
SELECT teachercourse.courseId FROM teachercourse
INNER JOIN teacher
on teacher.id = teachercourse.teacherId
WHERE teacher.UserId = uid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetCourselListByTeacherId` (IN `tid` INT(11))  NO SQL
SELECT teachercourse.id, course.prefix, course.course_no, course.course_tittle, course.postfix, session.session FROM teachercourse
INNER JOIN course on teachercourse.courseId = course.id
INNER JOIN degreesessionyearterm on teachercourse.DegreeSessionYearTermId = degreesessionyearterm.id
INNER JOIN session on degreesessionyearterm.sessionId = session.id
WHERE teachercourse.teacherId =tid
AND teachercourse.isclosed = 0
ORDER BY course.course_no$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetCouserPreFixCodeNameByVersityDeptId` (IN `vdid` INT(11))  NO SQL
SELECT course.id, course.prefix ,course.course_no, course.course_tittle, course.postfix FROM course
WHERE course.versityDeptId = vdid ORDER BY course.course_no$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetCtAssMSIdSidByTCId` (IN `tcid` INT)  NO SQL
SELECT mark.id, mark.markSectiontId, mark.studentId, 
student.studentId as s FROM mark
INNER JOIN marksection on marksection.id = mark.markSectiontId
INNER JOIN student on 	student.id = mark.studentId
WHERE marksection.teacherCourseId = tcid
AND marksection.sectionNameId != 1
ORDER BY s$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetDegreeSessionYearTermIdBYAllIndex` (IN `did` INT(11), IN `sid` INT(11), IN `yid` INT(11), IN `tid` INT(11))  NO SQL
SELECT degreesessionyearterm.id FROM degreesessionyearterm WHERE degreesessionyearterm.degreeId = did AND degreesessionyearterm.sessionId = sid AND degreesessionyearterm.yearId = yid AND degreesessionyearterm.termId = tid LIMIT 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetDeptByVdId` (IN `vdid` INT(11))  NO SQL
SELECT dept.name  
FROM versitydept 
INNER JOIN dept
ON versitydept.deptId = dept.id
WHERE versitydept.id = vdid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getDeptByVersityId` (IN `pid` INT)  NO SQL
SELECT dept.id, dept.name FROM dept INNER JOIN versitydept ON dept.id = versitydept.deptId WHERE versitydept.versityId = pid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetDesignationIDByUserId` (IN `uid` VARCHAR(256))  NO SQL
SELECT teacher.designationid FROM teacher
WHERE teacher.UserId = uid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetLastInsertIdOfMarkSection4AssByTcid` (IN `tcid` INT(11))  NO SQL
SELECT MAX(marksection.id) FROM marksection
WHERE marksection.teacherCourseId = tcid
AND marksection.sectionNameId >= 7$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetLastInsertIdOfMarkSection4CtAssByTcid` (IN `tcid` INT(11))  NO SQL
SELECT MAX(marksection.id) FROM marksection
WHERE marksection.teacherCourseId = tcid
AND marksection.sectionNameId != 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetLastInsertIdOfSectionName` ()  NO SQL
SELECT MAX(sectionname.id) FROM sectionname LIMIT 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetMarkSectionIdForAttendenceByTCID` (IN `tcid` INT(11))  NO SQL
SELECT marksection.id FROM marksection
WHERE marksection.teacherCourseId = tcid
AND marksection.sectionNameId = 1 LIMIT 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetMarksectionIdForCtByTcid` (IN `tcid` INT(11))  NO SQL
select marksection.id FROM marksection 
WHERE marksection.sectionNameId >= 2
AND marksection.sectionNameId <= 6
AND marksection.teacherCourseId = tcid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetMarkSectionParcentageByTCID` (IN `tcid` INT(11))  NO SQL
SELECT marksection.sectionPercentage FROM marksection 
WHERE marksection.teacherCourseId = tcid
LIMIT 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetNotApprovedStudentByTeacherCourseId` (IN `tcid` INT(11))  NO SQL
SELECT studentusercourse.id, student.studentId, users.FirstName, users.LastName FROM studentusercourse
INNER JOIN student on studentusercourse.studentid = student.id
INNER JOIN users on student.userid = users.Id
WHERE studentusercourse.teachercourseid = tcid
AND studentusercourse.isconfirmed = 0
ORDER BY student.studentId$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetOpenedCrourseNameBySessionIDTeacherID` (IN `tid` INT(11), IN `sid` INT(11))  NO SQL
SELECT course.id, course.prefix, course.course_no, course.course_tittle, course.postfix FROM teachercourse
INNER JOIN degreesessionyearterm 
on degreesessionyearterm.id = teachercourse.DegreeSessionYearTermId
INNER JOIN session on session.id = degreesessionyearterm.sessionId
INNER JOIN course on course.id = teachercourse.courseId
WHERE session.id = sid 
AND teachercourse.teacherId = tid
AND teachercourse.isclosed = 0$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPresentByAttnId` (IN `atnid` INT(11))  NO SQL
SELECT attendence.present FROM attendence
WHERE attendence.id = atnid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetSessionByTeacherId` (IN `tid` INT(11))  NO SQL
SELECT DISTINCT session.id, session.session FROM teachercourse 
INNER JOIN degreesessionyearterm 
on teachercourse.DegreeSessionYearTermId = degreesessionyearterm.id
INNER JOIN session 
on degreesessionyearterm.sessionId = session.id
WHERE teachercourse.teacherId = tid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetSessionByTeacherIdCourseId` (IN `tid` INT(11), IN `cid` INT(11))  NO SQL
SELECT teachercourse.id, session.session FROM teachercourse 
INNER JOIN degreesessionyearterm 
on teachercourse.DegreeSessionYearTermId = degreesessionyearterm.id
INNER JOIN session 
on degreesessionyearterm.sessionId = session.id
WHERE teachercourse.teacherId = tid 
AND teachercourse.courseId = cid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetSidSnameBysid` (IN `sid` INT(11))  NO SQL
SELECT student.studentId, student.batch, 
users.FirstName, users.LastName FROM student
INNER JOIN users on users.id = student.userid
WHERE student.id = sid 
ORDER BY student.studentId$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetSidSnameDatePresentByMarkIdSid` (IN `mrid` INT(11))  NO SQL
SELECT mark.id, student.studentId, users.FirstName, 
users.LastName, attendence.date AS dateColumn,  
attendence.present from mark
INNER JOIN student on student.id = mark.studentId
INNER JOIN users on users.Id = student.userid
INNER JOIN attendence on attendence.markId = mark.id
WHERE mark.id = mrid
ORDER BY dateColumn$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetSidSnameMarksByMarkIdSid` (IN `mrid` INT)  NO SQL
SELECT mark.id, mark.mark, student.studentId, 
users.FirstName, users.LastName, marksection.sectionPercentage, sectionname.name from mark
INNER JOIN student on student.id = mark.studentId
INNER JOIN users on users.Id = student.userid
INNER JOIN marksection on marksection.id = mark.markSectiontId
INNER JOIN sectionname on sectionname.id = marksection.sectionNameId
WHERE mark.id = mrid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetSidSnameMarksMarkIdByMarkSectionID` (IN `mrsid` INT(11))  NO SQL
SELECT mark.id, mark.mark, users.FirstName, users.LastName, student.studentId FROM mark
INNER JOIN marksection on marksection.id = mark.markSectiontId
INNER JOIN student on student.id = mark.studentId
INNER JOIN users on users.Id = student.userid
WHERE marksection.id = mrsid
ORDER BY student.studentId$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetStudentCourseIdByTCID` (IN `tcid` INT(11))  NO SQL
SELECT studentusercourse.id FROM studentusercourse
WHERE studentusercourse.teachercourseid = tcid
AND studentusercourse.isconfirmed = 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetStudentCourseIDbyTeacherCourseIdStudentId` (IN `tcid` INT(11), IN `sid` INT(11))  NO SQL
SELECT studentusercourse.id FROM studentusercourse
WHERE studentusercourse.teachercourseid = tcid 
AND studentusercourse.studentid = sid LIMIT 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetStudentIdByUserId` (IN `uid` VARCHAR(265))  NO SQL
SELECT student.studentId FROM student WHERE student.userid = uid LIMIT 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetStudentTableIdByScid` (IN `scid` INT(11))  NO SQL
SELECT student.id from studentusercourse 
INNER JOIN student on student.id = studentusercourse.studentid
WHERE studentusercourse.id = scid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetStudentTableIdByTcid` (IN `Tcid` INT(11))  NO SQL
SELECT studentusercourse.studentid FROM studentusercourse
WHERE studentusercourse.teachercourseid = tcid
AND studentusercourse.isconfirmed = 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetStudentTableIdByUserId` (IN `uid` VARCHAR(256))  NO SQL
SELECT student.id FROM student WHERE student.userid = uid LIMIT 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetTCIDByTID` (IN `tid` INT(11))  NO SQL
SELECT teachercourse.id FROM teachercourse
WHERE teachercourse.teacherId = tid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetTeacherCourceIdByTidDidCid` (IN `uid` INT(11), IN `did` INT(11), IN `cid` INT(11))  NO SQL
SELECT teachercourse.id FROM teachercourse 
WHERE teachercourse.teacherId = uid 
AND teachercourse.DegreeSessionYearTermId = did
AND teachercourse.courseId = cid LIMIT 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetTeacherIdByUserId` (IN `uid` VARCHAR(256))  NO SQL
SELECT teacher.id FROM teacher  WHERE teacher.UserId = uid LIMIT 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetTeacherNameByCourseId` (IN `cid` INT(11))  NO SQL
SELECT DISTINCT teachercourse.teacherId, users.FirstName, users.LastName FROM teachercourse
INNER JOIN teacher ON teachercourse.teacherId = teacher.id
INNER JOIN users ON teacher.UserId = users.Id
WHERE teachercourse.courseId = cid
AND teachercourse.isclosed = 0$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetTNameCNameCsBySID` (IN `sid` INT(11))  NO SQL
SELECT studentusercourse.id, users.FirstName, users.LastName, course.prefix, course.course_no, course.postfix, course.course_tittle, studentusercourse.isconfirmed FROM studentusercourse
INNER JOIN teachercourse on teachercourse.id = studentusercourse.teachercourseid
INNER JOIN course on course.id = teachercourse.courseId
INNER JOIN teacher on teachercourse.teacherId = teacher.id
INNER JOIN users on users.Id = teacher.UserId
INNER JOIN student on student.id = studentusercourse.studentid
WHERE student.Id = sid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetVersityByVdID` (IN `vdid` INT(11))  NO SQL
SELECT versity.name  
FROM versitydept 
INNER JOIN versity
ON versitydept.versityId = versity.id
WHERE versitydept.id = vdid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetVersityDeptByAllIndex` (IN `vid` INT(11), IN `did` INT(11))  NO SQL
SELECT versitydept.id FROM versitydept
WHERE versitydept.versityId = vid AND versitydept.deptId = did LIMIT 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getVersityDeptId` (IN `vid` INT, IN `did` INT)  NO SQL
SELECT versitydept.id FROM versitydept WHERE versitydept.versityId = vid AND versitydept.deptId = did LiMIT 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetVersityDeptIdByUserId` (IN `uid` VARCHAR(128))  NO SQL
SELECT users.versityDeptId FROM users WHERE users.Id = uid LIMIT 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetVersityDeptIdByVersityIdDeptID` (IN `pversityid` INT, IN `pdeptid` INT)  NO SQL
SELECT versitydept.id FROM versitydept where versitydept.versityId = pversityid and versitydept.deptId = pdeptid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `loadAllAssName` ()  NO SQL
SELECT sectionname.id, sectionname.name FROM sectionname
WHERE sectionname.id >= 7$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `loadAllCtName` ()  NO SQL
select sectionname.id , sectionname.name FROM sectionname
WHERE sectionname.id >= 2
AND sectionname.id <= 6$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `OpenTeacherCourseByTidCid` (IN `tid` INT(11), IN `cid` INT(11))  NO SQL
UPDATE teachercourse SET teachercourse.isclosed = 0
WHERE teachercourse.teacherId=tid
AND teachercourse.courseId =cid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateAttendanceByAtnIdPresent` (IN `atnid` INT(11), IN `pr` TINYINT(1))  NO SQL
UPDATE attendence SET attendence.present = pr
WHERE attendence.id = atnid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateAttendancemarkperBytcid` (IN `tcid` INT(11), IN `mr` INT(11))  NO SQL
UPDATE marksection 
SET marksection.sectionPercentage = mr
WHERE marksection.teacherCourseId = tcid
AND marksection.sectionNameId = 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateAttendanceSectionByid` (IN `id` INT(11), IN `start` INT(11), IN `end` INT(11), IN `mark` INT(11), IN `de` BOOLEAN)  NO SQL
UPDATE attendencesection 
SET attendencesection.start = start,
attendencesection.end = end,
attendencesection.mark = mark,
attendencesection.asDefault = de
WHERE attendencesection.id = id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateAttendanceSectionByTCId` (IN `tcid` INT(11), IN `ns` INT(11))  NO SQL
UPDATE attendancesection SET attendancesection.numberOfSection = ns
WHERE attendancesection.teacherCourseId = tcid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateDesignationIDByUserId` (IN `uid` VARCHAR(256), IN `did` INT(11))  NO SQL
UPDATE teacher SET teacher.designationid =did  WHERE teacher.UserId = uid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateIsConfirmFalseByStudentCourseID` (IN `scid` INT(11))  NO SQL
UPDATE studentusercourse 
SET studentusercourse.isconfirmed = 0
WHERE studentusercourse.id = scid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateIsConfirmTrueByStudentCourseID` (IN `scid` INT(11))  NO SQL
UPDATE studentusercourse 
SET studentusercourse.isconfirmed = 1
WHERE studentusercourse.id = scid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateMarkByMarkID` (IN `mrid` INT(11), IN `mark` INT(11))  NO SQL
UPDATE mark SET mark.mark = mark 
WHERE mark.id = mrid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateMarkSectionByTCID` (IN `tcid` INT(11), IN `mark` INT(11))  NO SQL
UPDATE marksection SET marksection.sectionPercentage = mark
WHERE marksection.teacherCourseId = tcid$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `attendence`
--

CREATE TABLE `attendence` (
  `id` int(11) NOT NULL,
  `markId` int(11) NOT NULL,
  `date` date NOT NULL,
  `present` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `attendence`
--

INSERT INTO `attendence` (`id`, `markId`, `date`, `present`) VALUES
(99, 103, '2016-12-27', 1),
(100, 104, '2016-12-27', 1),
(101, 105, '2016-12-27', 1),
(102, 106, '2016-12-27', 1),
(103, 107, '2016-12-27', 1),
(104, 108, '2016-12-27', 1),
(105, 109, '2016-12-27', 1),
(106, 110, '2016-12-27', 1),
(107, 111, '2016-12-27', 1),
(108, 112, '2016-12-27', 1),
(109, 113, '2016-12-27', 1),
(110, 114, '2016-12-27', 1),
(111, 115, '2016-12-27', 1),
(112, 116, '2016-12-27', 1),
(113, 103, '2016-12-01', 1),
(114, 104, '2016-12-01', 1),
(115, 105, '2016-12-01', 1),
(116, 106, '2016-12-01', 1),
(117, 107, '2016-12-01', 1),
(118, 108, '2016-12-01', 0),
(119, 109, '2016-12-01', 0),
(120, 110, '2016-12-01', 0),
(121, 111, '2016-12-01', 0),
(122, 112, '2016-12-01', 1),
(123, 113, '2016-12-01', 1),
(124, 114, '2016-12-01', 1),
(125, 115, '2016-12-01', 1),
(126, 116, '2016-12-01', 1),
(127, 103, '2016-12-02', 0),
(128, 104, '2016-12-02', 0),
(129, 105, '2016-12-02', 0),
(130, 106, '2016-12-02', 1),
(131, 107, '2016-12-02', 1),
(132, 108, '2016-12-02', 1),
(133, 109, '2016-12-02', 1),
(134, 110, '2016-12-02', 1),
(135, 111, '2016-12-02', 1),
(136, 112, '2016-12-02', 1),
(137, 113, '2016-12-02', 1),
(138, 114, '2016-12-02', 1),
(139, 115, '2016-12-02', 1),
(140, 116, '2016-12-02', 1),
(141, 103, '2016-12-28', 1),
(142, 104, '2016-12-28', 1),
(143, 105, '2016-12-28', 1),
(144, 106, '2016-12-28', 1),
(145, 107, '2016-12-28', 1),
(146, 108, '2016-12-28', 1),
(147, 109, '2016-12-28', 1),
(148, 110, '2016-12-28', 1),
(149, 111, '2016-12-28', 0),
(150, 112, '2016-12-28', 1),
(151, 113, '2016-12-28', 1),
(152, 114, '2016-12-28', 1),
(153, 115, '2016-12-28', 1),
(154, 116, '2016-12-28', 1),
(155, 103, '2016-12-05', 1),
(156, 104, '2016-12-05', 1),
(157, 105, '2016-12-05', 1),
(158, 106, '2016-12-05', 1),
(159, 107, '2016-12-05', 1),
(160, 108, '2016-12-05', 1),
(161, 109, '2016-12-05', 1),
(162, 110, '2016-12-05', 1),
(163, 111, '2016-12-05', 1),
(164, 112, '2016-12-05', 1),
(165, 113, '2016-12-05', 1),
(166, 114, '2016-12-05', 1),
(167, 115, '2016-12-05', 1),
(168, 116, '2016-12-05', 1),
(169, 103, '2016-12-06', 1),
(170, 104, '2016-12-06', 1),
(171, 105, '2016-12-06', 1),
(172, 106, '2016-12-06', 1),
(173, 107, '2016-12-06', 1),
(174, 108, '2016-12-06', 1),
(175, 109, '2016-12-06', 1),
(176, 110, '2016-12-06', 1),
(177, 111, '2016-12-06', 1),
(178, 112, '2016-12-06', 1),
(179, 113, '2016-12-06', 1),
(180, 114, '2016-12-06', 1),
(181, 115, '2016-12-06', 1),
(182, 116, '2016-12-06', 1),
(183, 103, '2016-12-07', 1),
(184, 104, '2016-12-07', 1),
(185, 105, '2016-12-07', 1),
(186, 106, '2016-12-07', 1),
(187, 107, '2016-12-07', 1),
(188, 108, '2016-12-07', 1),
(189, 109, '2016-12-07', 1),
(190, 110, '2016-12-07', 1),
(191, 111, '2016-12-07', 1),
(192, 112, '2016-12-07', 1),
(193, 113, '2016-12-07', 1),
(194, 114, '2016-12-07', 1),
(195, 115, '2016-12-07', 1),
(196, 116, '2016-12-07', 1),
(197, 103, '2016-12-08', 1),
(198, 104, '2016-12-08', 1),
(199, 105, '2016-12-08', 1),
(200, 106, '2016-12-08', 1),
(201, 107, '2016-12-08', 1),
(202, 108, '2016-12-08', 1),
(203, 109, '2016-12-08', 1),
(204, 110, '2016-12-08', 1),
(205, 111, '2016-12-08', 1),
(206, 112, '2016-12-08', 1),
(207, 113, '2016-12-08', 1),
(208, 114, '2016-12-08', 1),
(209, 115, '2016-12-08', 1),
(210, 116, '2016-12-08', 1);

-- --------------------------------------------------------

--
-- Table structure for table `attendencesection`
--

CREATE TABLE `attendencesection` (
  `id` int(11) NOT NULL,
  `start` int(11) NOT NULL,
  `end` int(11) NOT NULL,
  `mark` int(11) NOT NULL,
  `teacherCourceId` int(11) NOT NULL,
  `asDefault` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `attendencesection`
--

INSERT INTO `attendencesection` (`id`, `start`, `end`, `mark`, `teacherCourceId`, `asDefault`) VALUES
(74, 1, 10, 1, 8, 1),
(75, 11, 20, 2, 8, 1),
(76, 21, 30, 3, 8, 1),
(77, 31, 40, 4, 8, 1),
(78, 41, 50, 5, 8, 1),
(79, 51, 60, 6, 8, 1),
(80, 61, 70, 7, 8, 1),
(81, 71, 80, 8, 8, 1),
(82, 81, 90, 9, 8, 1),
(83, 91, 100, 10, 8, 1),
(184, 1, 10, 1, 7, 0),
(185, 11, 20, 2, 7, 0),
(186, 21, 30, 3, 7, 0),
(187, 31, 40, 4, 7, 0),
(188, 41, 50, 5, 7, 0),
(189, 51, 60, 6, 7, 0),
(190, 61, 70, 7, 7, 0),
(191, 71, 80, 8, 7, 0),
(192, 81, 90, 9, 7, 0),
(193, 91, 100, 10, 7, 0);

-- --------------------------------------------------------

--
-- Table structure for table `course`
--

CREATE TABLE `course` (
  `id` int(11) NOT NULL,
  `prefix` text NOT NULL,
  `course_no` int(11) NOT NULL,
  `postfix` text,
  `course_tittle` text NOT NULL,
  `versityDeptId` int(11) NOT NULL,
  `credit` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `course`
--

INSERT INTO `course` (`id`, `prefix`, `course_no`, `postfix`, `course_tittle`, `versityDeptId`, `credit`) VALUES
(9, 'CSE', 1101, '', 'Computer Fundamentals', 1, 2),
(10, 'CSE', 1103, '', 'Structured Programming', 1, 3),
(11, 'MATH', 1153, '', 'Calculus', 1, 3),
(12, 'asd', 21454, '', 'asdasd', 1, 2.3);

-- --------------------------------------------------------

--
-- Table structure for table `degree`
--

CREATE TABLE `degree` (
  `id` int(11) NOT NULL,
  `levelName` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `degree`
--

INSERT INTO `degree` (`id`, `levelName`) VALUES
(1, 'Under Graguate'),
(2, 'Post Graguate');

-- --------------------------------------------------------

--
-- Table structure for table `degreesessionyearterm`
--

CREATE TABLE `degreesessionyearterm` (
  `id` int(11) NOT NULL,
  `degreeId` int(11) NOT NULL,
  `sessionId` int(11) NOT NULL,
  `yearId` int(11) DEFAULT NULL,
  `termId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `degreesessionyearterm`
--

INSERT INTO `degreesessionyearterm` (`id`, `degreeId`, `sessionId`, `yearId`, `termId`) VALUES
(1, 1, 1, 8, 14),
(6, 1, 4, 8, 14);

-- --------------------------------------------------------

--
-- Table structure for table `dept`
--

CREATE TABLE `dept` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dept`
--

INSERT INTO `dept` (`id`, `name`) VALUES
(1, 'CSE'),
(2, 'ECE'),
(3, 'EEE'),
(4, '5');

-- --------------------------------------------------------

--
-- Table structure for table `designation`
--

CREATE TABLE `designation` (
  `id` int(11) NOT NULL,
  `designation` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `designation`
--

INSERT INTO `designation` (`id`, `designation`) VALUES
(1, 'Professor'),
(2, 'Lecturer');

-- --------------------------------------------------------

--
-- Table structure for table `mark`
--

CREATE TABLE `mark` (
  `id` int(11) NOT NULL,
  `markSectiontId` int(11) NOT NULL,
  `studentId` int(11) NOT NULL,
  `mark` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `mark`
--

INSERT INTO `mark` (`id`, `markSectiontId`, `studentId`, `mark`) VALUES
(103, 2, 5, NULL),
(104, 2, 6, NULL),
(105, 2, 7, NULL),
(106, 2, 8, NULL),
(107, 2, 9, NULL),
(108, 2, 10, NULL),
(109, 2, 11, NULL),
(110, 2, 12, NULL),
(111, 2, 13, NULL),
(112, 2, 14, NULL),
(113, 2, 15, NULL),
(114, 2, 16, NULL),
(115, 2, 17, NULL),
(116, 2, 4, NULL),
(310, 44, 4, NULL),
(311, 44, 5, NULL),
(312, 44, 6, NULL),
(313, 44, 7, NULL),
(314, 44, 8, NULL),
(315, 44, 9, NULL),
(316, 44, 10, NULL),
(317, 44, 11, NULL),
(318, 44, 12, NULL),
(319, 44, 13, NULL),
(320, 44, 14, NULL),
(321, 44, 15, NULL),
(322, 44, 16, NULL),
(323, 44, 17, NULL),
(324, 45, 4, NULL),
(325, 45, 5, NULL),
(326, 45, 6, NULL),
(327, 45, 7, NULL),
(328, 45, 8, NULL),
(329, 45, 9, NULL),
(330, 45, 10, NULL),
(331, 45, 11, NULL),
(332, 45, 12, NULL),
(333, 45, 13, NULL),
(334, 45, 14, NULL),
(335, 45, 15, NULL),
(336, 45, 16, NULL),
(337, 45, 17, NULL),
(339, 1, 5, NULL),
(340, 1, 4, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `marksection`
--

CREATE TABLE `marksection` (
  `id` int(11) NOT NULL,
  `teacherCourseId` int(11) NOT NULL,
  `sectionNameId` int(11) NOT NULL,
  `sectionPercentage` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `marksection`
--

INSERT INTO `marksection` (`id`, `teacherCourseId`, `sectionNameId`, `sectionPercentage`) VALUES
(1, 7, 1, 10),
(2, 8, 1, 10),
(44, 8, 16, 20),
(45, 8, 17, 20),
(46, 10, 1, 10);

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `Id` varchar(128) NOT NULL,
  `Name` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`Id`, `Name`) VALUES
('810d28a1-70b4-42b6-a588-e0e8bdd36920', 'Student'),
('f82ec3b1-22f7-42e2-92a6-60f890ff04a6', 'Teacher');

-- --------------------------------------------------------

--
-- Table structure for table `salutation`
--

CREATE TABLE `salutation` (
  `id` int(11) NOT NULL,
  `salutation` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `salutation`
--

INSERT INTO `salutation` (`id`, `salutation`) VALUES
(1, 'Mr.'),
(2, 'Mrs.');

-- --------------------------------------------------------

--
-- Table structure for table `sectionname`
--

CREATE TABLE `sectionname` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sectionname`
--

INSERT INTO `sectionname` (`id`, `name`) VALUES
(1, 'attendence'),
(16, 'CT1'),
(17, 'CT2');

-- --------------------------------------------------------

--
-- Table structure for table `session`
--

CREATE TABLE `session` (
  `id` int(11) NOT NULL,
  `session` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `session`
--

INSERT INTO `session` (`id`, `session`) VALUES
(1, '2016-17'),
(2, '2015-16'),
(3, '2014-15'),
(4, '2013-14'),
(5, '2012-13'),
(6, '2011-12');

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `id` int(11) NOT NULL,
  `studentId` varchar(16) NOT NULL,
  `batch` text NOT NULL,
  `userid` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`id`, `studentId`, `batch`, `userid`) VALUES
(4, '150231', '2015', '28791409-eb05-4997-8051-286bc913c1b7'),
(5, '150201', '2015', '1584f52a-5e44-48c9-a3df-ad55c721eb82'),
(6, '150202', '2015', '378c85e3-213a-4d05-b719-b058fdf71dd4'),
(7, '150203', '2015', '1ab0a465-c108-4174-9418-14278c961648'),
(8, '150204', '2015', '97919d2a-e130-4075-8244-461cbab85ee0'),
(9, '150205', '2015', '5e2c2d23-f558-499d-b4fd-e374049ecc8f'),
(10, '150206', '2015', '2fee2bd7-d7f0-49a6-8995-b9ee72ece28a'),
(11, '150207', '2015', 'f9fac2a0-c394-4eef-ac26-3decd0c0b126'),
(12, '150208', '2015', '508351dd-19ff-48da-a87e-ac4fa04a5608'),
(13, '150209', '2015', 'fdd51407-88cd-4296-8461-ba33416c8f0a'),
(14, '150210', '2015', '302cb7a1-2638-45eb-a46d-4a7ab35a8f69'),
(15, '150211', '2015', '4486f374-b2cc-490f-a4de-a1ab8a30da1c'),
(16, '150212', '2015', '3a5157f2-e57d-4ffe-beed-12d184aa7fde'),
(17, '150213', '2015', 'c6e6bea6-7b4e-4186-ba1b-613d44b06d01');

-- --------------------------------------------------------

--
-- Table structure for table `studentusercourse`
--

CREATE TABLE `studentusercourse` (
  `id` int(11) NOT NULL,
  `teachercourseid` int(11) NOT NULL,
  `studentid` int(11) NOT NULL,
  `isconfirmed` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `studentusercourse`
--

INSERT INTO `studentusercourse` (`id`, `teachercourseid`, `studentid`, `isconfirmed`) VALUES
(1, 7, 4, 1),
(3, 8, 4, 1),
(4, 8, 5, 1),
(5, 7, 5, 1),
(6, 8, 6, 1),
(7, 8, 7, 1),
(8, 8, 8, 1),
(9, 8, 9, 1),
(10, 8, 10, 1),
(11, 8, 11, 1),
(12, 8, 12, 1),
(13, 8, 13, 1),
(14, 8, 14, 1),
(15, 8, 15, 1),
(16, 8, 16, 1),
(17, 8, 17, 1),
(18, 10, 4, 0);

-- --------------------------------------------------------

--
-- Table structure for table `teacher`
--

CREATE TABLE `teacher` (
  `id` int(11) NOT NULL,
  `UserId` varchar(256) NOT NULL,
  `salutationid` int(11) NOT NULL,
  `designationid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `teacher`
--

INSERT INTO `teacher` (`id`, `UserId`, `salutationid`, `designationid`) VALUES
(1, 'acdfd863-5a11-4920-98f3-819808eec23b', 1, 2),
(5, 'f9affa70-49a3-41fe-9aa4-1deee5745033', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `teachercourse`
--

CREATE TABLE `teachercourse` (
  `id` int(11) NOT NULL,
  `teacherId` int(11) NOT NULL,
  `DegreeSessionYearTermId` int(11) NOT NULL,
  `courseId` int(11) NOT NULL,
  `isclosed` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `teachercourse`
--

INSERT INTO `teachercourse` (`id`, `teacherId`, `DegreeSessionYearTermId`, `courseId`, `isclosed`) VALUES
(7, 1, 1, 10, 0),
(8, 1, 1, 9, 0),
(9, 1, 1, 12, 0),
(10, 1, 1, 11, 0);

-- --------------------------------------------------------

--
-- Table structure for table `term`
--

CREATE TABLE `term` (
  `id` int(11) NOT NULL,
  `term` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `term`
--

INSERT INTO `term` (`id`, `term`) VALUES
(14, 'NULL'),
(15, '1'),
(16, '2'),
(17, '3');

-- --------------------------------------------------------

--
-- Table structure for table `userclaims`
--

CREATE TABLE `userclaims` (
  `Id` int(11) NOT NULL,
  `UserId` varchar(128) NOT NULL,
  `ClaimType` longtext,
  `ClaimValue` longtext
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `userlogins`
--

CREATE TABLE `userlogins` (
  `LoginProvider` varchar(128) NOT NULL,
  `ProviderKey` varchar(128) NOT NULL,
  `UserId` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `userroles`
--

CREATE TABLE `userroles` (
  `UserId` varchar(128) NOT NULL,
  `RoleId` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `userroles`
--

INSERT INTO `userroles` (`UserId`, `RoleId`) VALUES
('1584f52a-5e44-48c9-a3df-ad55c721eb82', '810d28a1-70b4-42b6-a588-e0e8bdd36920'),
('1ab0a465-c108-4174-9418-14278c961648', '810d28a1-70b4-42b6-a588-e0e8bdd36920'),
('28791409-eb05-4997-8051-286bc913c1b7', '810d28a1-70b4-42b6-a588-e0e8bdd36920'),
('2fee2bd7-d7f0-49a6-8995-b9ee72ece28a', '810d28a1-70b4-42b6-a588-e0e8bdd36920'),
('302cb7a1-2638-45eb-a46d-4a7ab35a8f69', '810d28a1-70b4-42b6-a588-e0e8bdd36920'),
('378c85e3-213a-4d05-b719-b058fdf71dd4', '810d28a1-70b4-42b6-a588-e0e8bdd36920'),
('3a5157f2-e57d-4ffe-beed-12d184aa7fde', '810d28a1-70b4-42b6-a588-e0e8bdd36920'),
('4486f374-b2cc-490f-a4de-a1ab8a30da1c', '810d28a1-70b4-42b6-a588-e0e8bdd36920'),
('508351dd-19ff-48da-a87e-ac4fa04a5608', '810d28a1-70b4-42b6-a588-e0e8bdd36920'),
('5e2c2d23-f558-499d-b4fd-e374049ecc8f', '810d28a1-70b4-42b6-a588-e0e8bdd36920'),
('97919d2a-e130-4075-8244-461cbab85ee0', '810d28a1-70b4-42b6-a588-e0e8bdd36920'),
('acdfd863-5a11-4920-98f3-819808eec23b', 'f82ec3b1-22f7-42e2-92a6-60f890ff04a6'),
('c6e6bea6-7b4e-4186-ba1b-613d44b06d01', '810d28a1-70b4-42b6-a588-e0e8bdd36920'),
('f9affa70-49a3-41fe-9aa4-1deee5745033', 'f82ec3b1-22f7-42e2-92a6-60f890ff04a6'),
('f9fac2a0-c394-4eef-ac26-3decd0c0b126', '810d28a1-70b4-42b6-a588-e0e8bdd36920'),
('fdd51407-88cd-4296-8461-ba33416c8f0a', '810d28a1-70b4-42b6-a588-e0e8bdd36920');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `Id` varchar(128) NOT NULL,
  `UserName` varchar(256) NOT NULL,
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `Email` varchar(256) DEFAULT NULL,
  `EmailConfirmed` tinyint(1) NOT NULL,
  `PasswordHash` longtext,
  `SecurityStamp` longtext,
  `PhoneNumber` longtext,
  `PhoneNumberConfirmed` tinyint(1) NOT NULL,
  `TwoFactorEnabled` tinyint(1) NOT NULL,
  `LockoutEndDateUtc` datetime DEFAULT NULL,
  `LockoutEnabled` tinyint(1) NOT NULL,
  `AccessFailedCount` int(11) NOT NULL,
  `sex` text NOT NULL,
  `versityDeptId` int(11) NOT NULL,
  `Address` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`Id`, `UserName`, `FirstName`, `LastName`, `Email`, `EmailConfirmed`, `PasswordHash`, `SecurityStamp`, `PhoneNumber`, `PhoneNumberConfirmed`, `TwoFactorEnabled`, `LockoutEndDateUtc`, `LockoutEnabled`, `AccessFailedCount`, `sex`, `versityDeptId`, `Address`) VALUES
('1584f52a-5e44-48c9-a3df-ad55c721eb82', 'a1', 'anik', 'ada', 'a1@a1.com', 0, 'AKFosx4rxOY4VVk3qARCY+dwS0fN8SHdMmT5IUkP+n68Pl+PwXDH5Z9VBQzDMk81WA==', '79f2074e-6caa-4550-b3c1-1197cdce296d', '12', 0, 0, '2016-10-18 01:31:30', 0, 0, 'Male', 1, 'asdasf'),
('1ab0a465-c108-4174-9418-14278c961648', 'a3', 'asdasd', 'adaqwrqw', 'a2@g.com', 0, 'ABqAi4xJDBbBvQXdjbIuhLKj6/wWUv+BU2hkExUp2PdkJh1P1Jj1uMsKcfRSET1+DA==', '24d1f0e5-05ad-4ffd-98ab-8b29399ce649', '11', 0, 0, '2016-10-19 14:31:29', 0, 0, 'Male', 1, 'asdsad'),
('28791409-eb05-4997-8051-286bc913c1b7', 'anikpro', 'anik', 'rahman', 'Teacher@g.com', 0, 'APDTb1ha1g7BScV5ehLiOJh+AFrVrDo8H0Ick+ekEjEuz1BPqWmgMd2pG2hzNFaQTw==', 'a1dd45e2-f588-4915-9dfe-203e43432859', '1255', 0, 0, '2016-09-26 17:41:34', 0, 0, 'Male', 1, 'ad.asdasd,asdasd'),
('2fee2bd7-d7f0-49a6-8995-b9ee72ece28a', 'a6', 'fbhdgsdfk b', 'sdfklsd ja', 'adaa2@g.com', 0, 'ANnNowQynokba3dZ5SgEdxXYTJrHOB0CndOv3ebM698rB8OPAIL4V9RLUmVhDL32Hw==', '097c3030-818c-4872-87b8-37a94d35cd64', '21251454', 0, 0, '2016-10-19 14:34:18', 0, 0, 'Other', 1, 'asdasdsadsad'),
('302cb7a1-2638-45eb-a46d-4a7ab35a8f69', 'a10', 'dfwf', 'werwer', 'a2@a.com', 0, 'AI7Z1bLm36ObekaZtHioryDimkSWaFzz4oGdEFF9FQ1IRMGgyeRzhxxLvK3ZdzzPXw==', '4758da44-c2aa-4d4e-b54c-d228be1abc56', NULL, 0, 0, '2016-10-20 01:44:24', 0, 0, 'Female', 1, ''),
('378c85e3-213a-4d05-b719-b058fdf71dd4', 'a2', 'qweqwewq', 'qweqweqwe', 'a2@g.com', 0, 'AIcE+0es7RCqilS97uJQA+wuwFG2OZN5msSW72XWThOMtPnS0fYUcXNX3qX+mDmPCA==', 'cabd3602-464c-452b-9ae1-73801cdd7bae', '13', 0, 0, '2016-10-19 14:30:45', 0, 0, 'Male', 1, 'asdasd'),
('3a5157f2-e57d-4ffe-beed-12d184aa7fde', 'a12', 'addq', 'qweqwe', 'a2@a.com', 0, 'AOxfmUPWjcYuV+Wn6yLEg2hi54NheM70belE+jUvWtWAf64ClvsR6D1BtU/jSeQyFw==', '3645a94f-255a-498e-80c5-97a5b5dc60bc', NULL, 0, 0, '2016-10-20 01:45:58', 0, 0, 'Female', 1, ''),
('4486f374-b2cc-490f-a4de-a1ab8a30da1c', 'a11', 'qwefdhgfj', 'fgjdfts', 'a2@a.com', 0, 'AB5nHgQjV87tVtr3LLKJpOQwFiy00JuJArLXaKTc/ZlkyNHkE77UnNr6aEPXyKBtrQ==', 'd093e804-6601-44fe-91e5-a2494ca740ca', NULL, 0, 0, '2016-10-20 01:44:55', 0, 0, 'Female', 1, ''),
('508351dd-19ff-48da-a87e-ac4fa04a5608', 'a8', 'wqeqwe', 'qwdqd', 'a2@a.com', 0, 'AMWPwW5LX5rcmo02iMqtw0mtfr/gv/tAgV5hSqkW5iRDLE6jyXxtFso4/htGPZxYxA==', '256064d9-9579-4259-8a32-da9ba7c23d5d', '41564564', 0, 0, '2016-10-20 01:43:06', 0, 0, 'Female', 1, 'asdasd'),
('5e2c2d23-f558-499d-b4fd-e374049ecc8f', 'a5', 'qwesad ', 'a dasdsad', 'a2@g.com', 0, 'AOxAG02HiDUfzjZZ2oCU4Q6mRkVUCcxIvT3FAEH2ivDeTOAZ5NO4KR8hdiFUZfYdgg==', 'eb5dfe60-cd1d-45bb-9d8a-8a7c81b1bcc0', '5456456', 0, 0, '2016-10-19 14:33:32', 0, 0, 'Male', 1, 'asdasdsad'),
('97919d2a-e130-4075-8244-461cbab85ee0', 'a4', 'edqwdf', 'asf aqdasd ', 'a2@g.com', 0, 'AI5WFSyEOGm74HwDknWLc47RKRzw9GlDkF+NEi8FFJRJLSyu4PrejPpQqG9rz5dONg==', '0998dc83-80de-4b86-94e8-138ba7d626ca', '321412', 0, 0, '2016-10-19 14:32:34', 0, 0, 'Female', 1, 'asdasdas \r\n'),
('acdfd863-5a11-4920-98f3-819808eec23b', 'Teacher', 'Sarfaraz', 'Newaz', 'tea@cher.com', 0, 'AHVAxB3GGeODh6d9YXo2kXtnv8leSVdpngIKEdVefiBVAMuf68ji6mOixm3njL0hzA==', '667d2c52-1deb-4166-ad94-e940bcb05756', '01911046898', 0, 0, '2016-09-19 20:18:37', 0, 0, 'Male', 1, 'Prantika, Nirala, Khulna'),
('c6e6bea6-7b4e-4186-ba1b-613d44b06d01', 'a13', 'dgssg', 'dasfsadf', 'sadf@asfdas.com', 0, 'AJF7dupetDswOI6LiRGGyvRbxkQfpE331irNFNikOlaSKxbQMFsIHuDTC4NHMcne9w==', '1964ff1f-6c36-44ae-8e25-08886e8b3e2f', NULL, 0, 0, '2016-10-20 08:33:07', 0, 0, 'Female', 1, ''),
('f9affa70-49a3-41fe-9aa4-1deee5745033', 'rCr_BD', 'Anik', 'Rahman', 'anik@anik.com', 0, 'AMJkDR2ztgOmIrlDy0Bbp+p1pIe6rFyyiNA+NXGU2ixxPbVgX49GDvnjJRT1CEGGAA==', 'cc4ac639-f873-4514-97fd-7c5668e7a8b1', '0124', 0, 0, '2016-09-23 12:55:47', 0, 0, 'Male', 1, 'asdasd'),
('f9fac2a0-c394-4eef-ac26-3decd0c0b126', 'a7', 'dasdasd', 'qeqweqwe', 'a2@a.com', 0, 'AOP74x7+eg/GB3LIuyOPI1/jHTtvH0PayD7yoT8q50tQJdrUdekTkG93C6ffQcO3WQ==', 'b435a94f-f32e-449a-85c7-4a4f9c45c81e', '564564', 0, 0, '2016-10-20 01:42:19', 0, 0, 'Female', 1, 'asdasdasd\r\n'),
('fdd51407-88cd-4296-8461-ba33416c8f0a', 'a9', 'fwrwe', 'aqwrqwrqw', 'a2@a.com', 0, 'AKRLPIYhtwUoEpE6S0TCBj3RloaHZB9UN7nQgg+gB12yP2pq/p8+PvWVR4Xs12rg8A==', '0b303d8a-d2f6-4dde-b781-1334e367d3cc', '4545', 0, 0, '2016-10-20 01:43:48', 0, 0, 'Female', 1, 'asdasd');

-- --------------------------------------------------------

--
-- Table structure for table `versity`
--

CREATE TABLE `versity` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `versity`
--

INSERT INTO `versity` (`id`, `name`) VALUES
(1, 'KU'),
(2, 'RU');

-- --------------------------------------------------------

--
-- Table structure for table `versitydept`
--

CREATE TABLE `versitydept` (
  `id` int(11) NOT NULL,
  `versityId` int(11) NOT NULL,
  `deptId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `versitydept`
--

INSERT INTO `versitydept` (`id`, `versityId`, `deptId`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 2, 1),
(4, 2, 3);

-- --------------------------------------------------------

--
-- Table structure for table `year`
--

CREATE TABLE `year` (
  `id` int(11) NOT NULL,
  `year` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `year`
--

INSERT INTO `year` (`id`, `year`) VALUES
(8, '1st'),
(9, '2nd'),
(10, '3rd'),
(11, '4th'),
(12, '5th');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `attendence`
--
ALTER TABLE `attendence`
  ADD PRIMARY KEY (`id`),
  ADD KEY `markId` (`markId`),
  ADD KEY `markId_2` (`markId`),
  ADD KEY `markId_3` (`markId`);

--
-- Indexes for table `attendencesection`
--
ALTER TABLE `attendencesection`
  ADD PRIMARY KEY (`id`),
  ADD KEY `teacherCourceId` (`teacherCourceId`);

--
-- Indexes for table `course`
--
ALTER TABLE `course`
  ADD PRIMARY KEY (`id`),
  ADD KEY `versityDeptId` (`versityDeptId`);

--
-- Indexes for table `degree`
--
ALTER TABLE `degree`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `degreesessionyearterm`
--
ALTER TABLE `degreesessionyearterm`
  ADD PRIMARY KEY (`id`),
  ADD KEY `degreeId` (`degreeId`),
  ADD KEY `sessionId` (`sessionId`),
  ADD KEY `yearId` (`yearId`),
  ADD KEY `termId` (`termId`);

--
-- Indexes for table `dept`
--
ALTER TABLE `dept`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `designation`
--
ALTER TABLE `designation`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mark`
--
ALTER TABLE `mark`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mark` (`mark`),
  ADD KEY `marksheetId` (`markSectiontId`),
  ADD KEY `markSectiontId` (`markSectiontId`),
  ADD KEY `studentId` (`studentId`),
  ADD KEY `markSectiontId_2` (`markSectiontId`);

--
-- Indexes for table `marksection`
--
ALTER TABLE `marksection`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sectionPercentage` (`sectionPercentage`),
  ADD KEY `sectionNameId` (`sectionNameId`),
  ADD KEY `teacherCourseId` (`teacherCourseId`),
  ADD KEY `sectionPercentage_2` (`sectionPercentage`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `salutation`
--
ALTER TABLE `salutation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`),
  ADD KEY `id_2` (`id`);

--
-- Indexes for table `sectionname`
--
ALTER TABLE `sectionname`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `session`
--
ALTER TABLE `session`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userid` (`userid`);

--
-- Indexes for table `studentusercourse`
--
ALTER TABLE `studentusercourse`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user` (`teachercourseid`),
  ADD KEY `stud` (`studentid`);

--
-- Indexes for table `teacher`
--
ALTER TABLE `teacher`
  ADD PRIMARY KEY (`id`),
  ADD KEY `salutationid` (`salutationid`),
  ADD KEY `designationid` (`designationid`),
  ADD KEY `UserId` (`UserId`);

--
-- Indexes for table `teachercourse`
--
ALTER TABLE `teachercourse`
  ADD PRIMARY KEY (`id`),
  ADD KEY `DegreeSessionYearTermId` (`DegreeSessionYearTermId`),
  ADD KEY `userId` (`teacherId`),
  ADD KEY `courseId` (`courseId`);

--
-- Indexes for table `term`
--
ALTER TABLE `term`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `userclaims`
--
ALTER TABLE `userclaims`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `Id` (`Id`),
  ADD KEY `UserId` (`UserId`);

--
-- Indexes for table `userlogins`
--
ALTER TABLE `userlogins`
  ADD PRIMARY KEY (`LoginProvider`,`ProviderKey`,`UserId`),
  ADD KEY `ApplicationUser_Logins` (`UserId`);

--
-- Indexes for table `userroles`
--
ALTER TABLE `userroles`
  ADD PRIMARY KEY (`UserId`,`RoleId`),
  ADD KEY `IdentityRole_Users` (`RoleId`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `versityDeptId` (`versityDeptId`);

--
-- Indexes for table `versity`
--
ALTER TABLE `versity`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `versitydept`
--
ALTER TABLE `versitydept`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `versityId_2` (`versityId`,`deptId`),
  ADD KEY `versityId` (`versityId`),
  ADD KEY `deptId` (`deptId`);

--
-- Indexes for table `year`
--
ALTER TABLE `year`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `attendence`
--
ALTER TABLE `attendence`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=211;
--
-- AUTO_INCREMENT for table `attendencesection`
--
ALTER TABLE `attendencesection`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=194;
--
-- AUTO_INCREMENT for table `course`
--
ALTER TABLE `course`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `degree`
--
ALTER TABLE `degree`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `degreesessionyearterm`
--
ALTER TABLE `degreesessionyearterm`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `dept`
--
ALTER TABLE `dept`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `designation`
--
ALTER TABLE `designation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `mark`
--
ALTER TABLE `mark`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=341;
--
-- AUTO_INCREMENT for table `marksection`
--
ALTER TABLE `marksection`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;
--
-- AUTO_INCREMENT for table `salutation`
--
ALTER TABLE `salutation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `sectionname`
--
ALTER TABLE `sectionname`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
--
-- AUTO_INCREMENT for table `session`
--
ALTER TABLE `session`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `student`
--
ALTER TABLE `student`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
--
-- AUTO_INCREMENT for table `studentusercourse`
--
ALTER TABLE `studentusercourse`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
--
-- AUTO_INCREMENT for table `teacher`
--
ALTER TABLE `teacher`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `teachercourse`
--
ALTER TABLE `teachercourse`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `term`
--
ALTER TABLE `term`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
--
-- AUTO_INCREMENT for table `userclaims`
--
ALTER TABLE `userclaims`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `versity`
--
ALTER TABLE `versity`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `versitydept`
--
ALTER TABLE `versitydept`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `year`
--
ALTER TABLE `year`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `attendence`
--
ALTER TABLE `attendence`
  ADD CONSTRAINT `attendence_ibfk_1` FOREIGN KEY (`markId`) REFERENCES `mark` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `attendencesection`
--
ALTER TABLE `attendencesection`
  ADD CONSTRAINT `attendencesection_ibfk_1` FOREIGN KEY (`teacherCourceId`) REFERENCES `teachercourse` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `course`
--
ALTER TABLE `course`
  ADD CONSTRAINT `course_ibfk_1` FOREIGN KEY (`versityDeptId`) REFERENCES `versitydept` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `degreesessionyearterm`
--
ALTER TABLE `degreesessionyearterm`
  ADD CONSTRAINT `degreesessionyearterm_ibfk_1` FOREIGN KEY (`yearId`) REFERENCES `year` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `degreesessionyearterm_ibfk_2` FOREIGN KEY (`termId`) REFERENCES `term` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `degreesessionyearterm_ibfk_3` FOREIGN KEY (`sessionId`) REFERENCES `session` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `degreesessionyearterm_ibfk_4` FOREIGN KEY (`degreeId`) REFERENCES `degree` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `mark`
--
ALTER TABLE `mark`
  ADD CONSTRAINT `mark_ibfk_2` FOREIGN KEY (`studentId`) REFERENCES `student` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mark_ibfk_3` FOREIGN KEY (`markSectiontId`) REFERENCES `marksection` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `marksection`
--
ALTER TABLE `marksection`
  ADD CONSTRAINT `marksection_ibfk_2` FOREIGN KEY (`sectionNameId`) REFERENCES `sectionname` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `marksection_ibfk_3` FOREIGN KEY (`teacherCourseId`) REFERENCES `teachercourse` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `student`
--
ALTER TABLE `student`
  ADD CONSTRAINT `student_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `users` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `studentusercourse`
--
ALTER TABLE `studentusercourse`
  ADD CONSTRAINT `studentusercourse_ibfk_1` FOREIGN KEY (`studentid`) REFERENCES `student` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `studentusercourse_ibfk_2` FOREIGN KEY (`teachercourseid`) REFERENCES `teachercourse` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `teacher`
--
ALTER TABLE `teacher`
  ADD CONSTRAINT `teacher_ibfk_1` FOREIGN KEY (`salutationid`) REFERENCES `salutation` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `teacher_ibfk_2` FOREIGN KEY (`designationid`) REFERENCES `designation` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `teacher_ibfk_3` FOREIGN KEY (`UserId`) REFERENCES `users` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `teachercourse`
--
ALTER TABLE `teachercourse`
  ADD CONSTRAINT `teachercourse_ibfk_1` FOREIGN KEY (`DegreeSessionYearTermId`) REFERENCES `degreesessionyearterm` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `teachercourse_ibfk_2` FOREIGN KEY (`courseId`) REFERENCES `course` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `teachercourse_ibfk_3` FOREIGN KEY (`teacherId`) REFERENCES `teacher` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `userclaims`
--
ALTER TABLE `userclaims`
  ADD CONSTRAINT `ApplicationUser_Claims` FOREIGN KEY (`UserId`) REFERENCES `users` (`Id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `userlogins`
--
ALTER TABLE `userlogins`
  ADD CONSTRAINT `ApplicationUser_Logins` FOREIGN KEY (`UserId`) REFERENCES `users` (`Id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `userroles`
--
ALTER TABLE `userroles`
  ADD CONSTRAINT `ApplicationUser_Roles` FOREIGN KEY (`UserId`) REFERENCES `users` (`Id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `IdentityRole_Users` FOREIGN KEY (`RoleId`) REFERENCES `roles` (`Id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`versityDeptId`) REFERENCES `versitydept` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `versitydept`
--
ALTER TABLE `versitydept`
  ADD CONSTRAINT `versitydept_ibfk_1` FOREIGN KEY (`versityId`) REFERENCES `versity` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `versitydept_ibfk_2` FOREIGN KEY (`deptId`) REFERENCES `dept` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
